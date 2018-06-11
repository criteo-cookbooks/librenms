#
# Cookbook:: librenms
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'apache2'
include_recipe 'logrotate'

librenms_rootdir = node['librenms']['root_dir']
librenms_homedir = ::File.join(node['librenms']['root_dir'], 'librenms')
librenms_logdir = ::File.join(librenms_homedir, 'logs')
librenms_rrddir = node['librenms']['rrd_dir']
librenms_bootstrap_cachedir = node['librenms']['bootstrap_cache_dir']
librenms_storagedir = node['librenms']['storage_dir']
librenms_username = node['librenms']['user']
librenms_group = node['librenms']['group']
librenms_version = node['librenms']['install']['version']
librenms_file = "#{librenms_version}.zip"
librenms_phpconfigfile = ::File.join(librenms_homedir, 'config.php')

case node['platform_family']
when 'debian'

  librenms_phpconf = '/etc/php/7.0/apache2/conf.d/25-librenms.ini'
  rrdcached_config = '/etc/default/rrdcached'

  package %w[composer fping git graphviz imagemagick libapache2-mod-php7.0 mariadb-client mariadb-server
             mtr-tiny nmap php7.0-cli php7.0-curl php7.0-gd php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql
             php7.0-snmp php7.0-xml php7.0-zip python-memcache python-mysqldb rrdtool snmp snmpd whois] do
    action :install
  end

  package 'php7.0-ldap' do
    action :install
    only_if { node['librenms']['auth_ad']['enabled'] }
  end

  package rrdcached do
    action :install
    only_if { node['librenms']['rrdcached']['enabled'] }
  end

  template rrdcached_config do
    source 'rrdcached.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      options:      node['librenms']['rrdcached']['options'],
      user_options: node['librenms']['rrdcached']['user_options'],
      user:         librenms_username,
      group:        librenms_group,
      dir:          librenms_rrddir,
    )
    notifies :restart, 'service[rrdcached]'
    only_if { node['librenms']['rrdcached']['enabled'] }
  end

  service 'mysql' do
    supports status: true, restart: true, reload: true
    action :start
  end

  service 'apache2' do
    supports status: true, restart: true, reload: true
    action :start
  end

  template '/etc/mysql/mariadb.conf.d/librenms-mysqld.cnf' do
    source 'librenms-mysqld.cnf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      bind_address: node['mariadb']['bind_address'],
      max_connections: node['mariadb']['max_connections'],
    )
    notifies :restart, 'service[mysql]'
  end

  apache_module 'php7' do
    filename 'libphp7.0.so'
  end

  apache_module 'mpm_event' do
    enable false
  end

  apache_module 'mpm_prefork' do
    enable true
  end

when 'rhel'

  librenms_phpconf = '/etc/php.d/librenms.ini'

  include_recipe 'yum-epel'

  package %w[mariadb mariadb-server]

  service 'mariadb' do
    supports status: true, restart: true, reload: true
    action :start
  end

  service 'httpd' do
    supports status: true, restart: true, reload: true
    action :start
  end

  template '/etc/my.cnf.d/librenms-mysqld.cnf' do
    source 'librenms-mysqld.cnf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables(bind_address: node['mariadb']['bind_address'])
    notifies :restart, 'service[mariadb]'
  end

  yum_repository 'webtatic' do
    description node['librenms']['repo_webtatic']['desc']
    baseurl node['librenms']['repo_webtatic']['url']
    gpgcheck true
    gpgkey node['librenms']['repo_webtatic']['gpgkey']
    enabled node['librenms']['repo_webtatic']['enabled']
  end

  yum_repository 'opennms' do
    description node['librenms']['repo_opennms']['desc']
    baseurl node['librenms']['repo_opennms']['url']
    gpgcheck true
    gpgkey node['librenms']['repo_opennms']['gpgkey']
    enabled node['librenms']['repo_opennms']['enabled']
    only_if { node['librenms']['rrdcached']['enabled'] }
  end

  package %w[php70w php70w-cli php70w-common php70w-curl php70w-gd php70w-mbstring
             php70w-mcrypt php70w-mysql php70w-process php70w-snmp net-snmp ImageMagick jwhois
             nmap mtr rrdtool MySQL-python net-snmp-utils composer cronie fping git unzip] do
    action :install
  end

  package 'php70w-ldap' do
    action :install
    only_if { node['librenms']['auth_ad']['enabled'] }
  end

  apache_module 'php7' do
    filename 'libphp7.so'
  end

  systemd_unit 'rrdcached.service' do
    content <<-FOO.gsub(/^\s+/, '')
    [Unit]
    Description=Data caching daemon for rrdtool
    After=network.service

    [Service]
    PIDFile=/var/run/rrdcached.pid
    ExecStart=/usr/sbin/rrdcached #{node['librenms']['rrdcached']['options']} -s #{node['librenms']['user']} -U #{node['librenms']['user']} -G #{node['librenms']['group']} -b #{node['librenms']['root_dir']}/librenms-#{librenms_version}/rrd
    User=root

    [Install]
    WantedBy=default.target

    FOO

    action %i[create enable]
    only_if { node['librenms']['rrdcached']['enabled'] }
  end

end

group librenms_group do
  action :create
end

user librenms_username do
  action :create
  comment 'LibreNMS user'
  group librenms_group
  home librenms_homedir
  shell '/bin/bash'
  manage_home false
end

ark 'librenms' do
  url "#{node['librenms']['install']['url']}/#{librenms_file}"
  path librenms_rootdir
  mode 0755
  checksum node['librenms']['install']['checksum'] unless node['librenms']['install']['checksum'].nil?
  version librenms_version
  owner librenms_username
  group librenms_group
  action :put
end

directory librenms_rrddir do
  owner librenms_username
  group librenms_group
  mode '0755'
  action :create
  not_if { ::File.exist? librenms_rrddir }
end

directory librenms_bootstrap_cachedir do
  owner librenms_username
  group librenms_group
  mode '0755'
  action :create
end

directory librenms_storagedir do
  owner librenms_username
  group librenms_group
  mode '0755'
  action :create
end

file ::File.join(librenms_homedir, '.env') do
  owner librenms_username
  group librenms_group
  mode '0644'
  content node['librenms']['env'].map { |k, v| "#{k}='#{v}'" }.join("\n")
end

template librenms_phpconf do
  source 'librenms.ini.erb'
  owner 'root'
  group 'root'
  variables(
    memory_limit: node['librenms']['phpini']['memory_limit'],
    timezone: node['librenms']['phpini']['timezone'],
  )
  mode '0644'
  case node['platform_family']
  when 'debian'
    notifies :reload, 'service[apache2]', ':immediately'
  when 'rhel'
    notifies :reload, 'service[httpd]', ':immediately'
  end
end

template '/tmp/create_db.sql' do
  source 'create_db.sql.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(password: node['mariadb']['user_librenms']['password'])
end

execute 'create_db' do
  action :run
  command 'mysql -uroot < /tmp/create_db.sql'
  cwd '/tmp'
  user 'root'
  group 'root'
  not_if 'echo "show tables;" | mysql -uroot librenms'
end

logrotate_app 'librenms' do
  cookbook 'logrotate'
  path librenms_logdir
  options %w[missingok delaycompress notifempty]
  frequency 'weekly'
  rotate 6
  create "644 #{librenms_username} #{librenms_group}"
end

service 'snmpd' do
  supports status: true, restart: true, reload: true
  action [:enable]
end

template '/etc/snmp/snmpd.conf' do
  source 'snmpd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    community: node['librenms']['snmp']['community'],
    contact:   node['librenms']['contact'],
    hostname:  node['librenms']['hostname'],
  )
  notifies :restart, 'service[snmpd]'
end

cookbook_file 'distro' do
  path '/usr/bin/distro'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[snmpd]', :delayed
end

web_app 'librenms' do
  server_port node['librenms']['web']['port']
  server_name node['hostname']
  server_alias node['librenms']['web']['name']
  docroot "#{librenms_homedir}/html"
  directory_options node['librenms']['web']['options']
  allow_override node['librenms']['web']['override']
end

template librenms_phpconfigfile do
  source 'config.php.erb'
  owner librenms_username
  group librenms_group
  mode '0644'
  variables(
    db_user:            node['mariadb']['user_librenms']['username'],
    db_pass:            node['mariadb']['user_librenms']['password'],
    database_name:      node['mariadb']['database']['name'],
    user:               librenms_username,
    path:               librenms_homedir,
    rrdc_enabled:       node['librenms']['rrdcached']['enabled'],
    auto_up:            node['librenms']['auto_update_enabled'],
    xdp:                node['librenms']['autodiscover']['xdp'],
    ospf:               node['librenms']['autodiscover']['ospf'],
    bgp:                node['librenms']['autodiscover']['bgp'],
    snmpscan:           node['librenms']['autodiscover']['snmpscan'],
    ad_enabled:         node['librenms']['auth_ad']['enabled'],
    ad_url:             node['librenms']['auth_ad']['url'],
    ad_domain:          node['librenms']['auth_ad']['domain'],
    ad_dn:              node['librenms']['auth_ad']['base_dn'],
    ad_check:           node['librenms']['auth_ad']['check_cert'],
    ad_user:            node['librenms']['auth_ad']['binduser'],
    ad_pass:            node['librenms']['auth_ad']['bindpassword'],
    ad_timeout:         node['librenms']['auth_ad']['timeout'],
    ad_debug:           node['librenms']['auth_ad']['debug_enabled'],
    ad_purge:           node['librenms']['auth_ad']['users_purge'],
    ad_req:             node['librenms']['auth_ad']['req_member'],
    ad_admlvl:          node['librenms']['auth_ad']['admingroup_level'],
    ad_usrlvl:          node['librenms']['auth_ad']['usergroup_level'],
    add_conf_file_path: node['librenms']['add_config_file']['path'],
    rrddir:             node['librenms']['rrd_dir'],
  )
end

execute 'install composer dependencies' do
  action :run
  command 'php scripts/composer_wrapper.php install --no-dev'
  cwd librenms_homedir
  user 'root'
  group 'root'
end

execute 'build base' do
  action :run
  command 'php build-base.php'
  cwd librenms_homedir
  user 'root'
  group 'root'
end

execute 'adduser admin' do
  action :run
  command 'php adduser.php $LIBRE_USER $LIBRE_PASS 10 $LIBRE_MAIL'
  cwd librenms_homedir
  environment(
    'LIBRE_USER' => node['librenms']['user_admin'],
    'LIBRE_PASS' => node['librenms']['user_pass'],
    'LIBRE_MAIL' => node['librenms']['contact'],
  )
  user 'root'
  group 'root'
end

include_recipe 'librenms::cron'
