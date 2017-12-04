
default['mariadb']['user_librenms']['password'] = 'default'

default['librenms']['root_dir'] = '/var/opt/'
default['librenms']['path'] = "node['librenms']['root_dir']/librenms"
default['librenms']['user']  = 'librenms'
default['librenms']['group'] = 'librenms'

# httpd related
default['librenms']['web']['name'] = 'librenms.example.com'
default['librenms']['web']['port'] = '80'
default['librenms']['web']['enablephp'] = true
default['librenms']['web']['options'] = 'FollowSymLinks MultiViews'
default['librenms']['web']['override'] = 'All'
default['librenms']['phpini']['timezone'] = 'UTC'

# snmpd
default['librenms']['snmp']['community'] = 'public'
default['librenms']['snmp']['distro'] = 'https://raw.githubusercontent.com/librenms/librenms-agent/master/snmp/distro'
default['librenms']['contact'] = 'webmaster@example.com'

# librenms user mgmt
default['librenms']['user_admin'] = 'admin'
default['librenms']['user_pass'] = 'admin'

# additional repos
default['librenms']['repo_webtatic']['url'] = 'https://repo.webtatic.com/yum/el7/$basearch/'
default['librenms']['repo_webtatic']['desc'] = 'Webtatic repo EL7'
default['librenms']['repo_rpmforge']['mirrorlist'] = 'http://mirrorlist.repoforge.org/el7/mirrors-rpmforge'
default['librenms']['repo_rpmforge']['url'] = 'http://mirrorlist.repoforge.org/el7/mirrors-rpmforge'
default['librenms']['repo_rpmforge']['desc'] = 'RPMForge repo EL7'

# downloading librenms
default['librenms']['install']['url'] = 'https://github.com/librenms/librenms/archive/'
default['librenms']['install']['version'] = 'master'
default['librenms']['install']['tmpdir'] = '/var/tmp/'

# cron jobs mgmt
default['librenms']['config']['poller_threads'] = '8'
default['librenms']['cron']['discovery_all'] = true
default['librenms']['cron']['discovery_new'] = true
default['librenms']['cron']['poller'] = true
default['librenms']['cron']['daily'] = true
default['librenms']['cron']['alerts'] = true
default['librenms']['cron']['poll-billing'] = true
default['librenms']['cron']['billing-calculate'] = true
default['librenms']['cron']['check'] = true

# rrdcached
default['librenms']['rrdcached']['enabled'] = false
default['librenms']['rrdcached']['config_file'] = '/etc/sysconfig/rrdcached'
default['librenms']['rrdcached']['options'] = '-w 1800 -z 1800 -f 3600 -B -R -j /var/tmp -l unix:/var/run/rrdcached/rrdcached.sock -t 4 -F'
default['librenms']['rrdcached']['path'] = "node['librenms']['path']/rrd"

# autodiscover switches
default['librenms']['autodiscover']['xdp'] = false
default['librenms']['autodiscover']['ospf'] = false
default['librenms']['autodiscover']['bgp'] = false
default['librenms']['autodiscover']['snmpscan'] = false
default['librenms']['network_discovery'] = ['10.0.0.0/8', '192.168.0.0/16']
