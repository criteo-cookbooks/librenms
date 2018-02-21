
default['mariadb']['user_librenms']['password'] = 'default'
default['mariadb']['bind_address'] = '127.0.0.1'

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
default['librenms']['contact'] = 'webmaster@example.com'

# librenms user mgmt
default['librenms']['user_admin'] = 'admin'
default['librenms']['user_pass'] = 'admin'

# additional repo
default['librenms']['repo_webtatic']['enabled'] = true
default['librenms']['repo_webtatic']['url'] = 'https://repo.webtatic.com/yum/el7/$basearch/'
default['librenms']['repo_webtatic']['desc'] = 'Webtatic repo EL7'
default['librenms']['repo_webtatic']['gpgkey'] = 'https://repo.webtatic.com/yum/RPM-GPG-KEY-webtatic-el7'
default['yum']['epel']['enabled'] = true

# downloading librenms
default['librenms']['install']['url'] = 'https://github.com/librenms/librenms/archive/'
default['librenms']['install']['version'] = '1.35'
default['librenms']['install']['checksum'] = '72019d9b58b145b617b1e9bfe7f39bd01c9fe5c254e561ef0c80b0a3eb56ac3f'
default['librenms']['install']['tmpdir'] = '/var/tmp/'
# override this with the proper archive checksum if you install a
# specific version and care about checksums.
default['librenms']['install']['checksum'] = nil

# auto_update - enabled by default (numerical boolean)
default['librenms']['auto_update_enabled'] = 1

# optional additional config file to include in config.php
default['librenms']['add_config_file']['enabled'] = false
default['librenms']['add_config_file']['path'] = ''

# cron jobs mgmt
default['librenms']['config']['poller_threads'] = '8'
default['librenms']['cron']['discovery_all']['enabled'] = true
default['librenms']['cron']['discovery_all']['hour'] = '*/6'
default['librenms']['cron']['discovery_all']['minute'] = '33'
default['librenms']['cron']['discovery_new']['enabled'] = true
default['librenms']['cron']['discovery_new']['hour'] = '*'
default['librenms']['cron']['discovery_new']['minute'] = '*/5'
default['librenms']['cron']['poller']['enabled'] = true
default['librenms']['cron']['poller']['hour'] = '*'
default['librenms']['cron']['poller']['minute'] = '*/5'
default['librenms']['cron']['daily']['enabled'] = true
default['librenms']['cron']['daily']['hour'] = '*'
default['librenms']['cron']['daily']['minute'] = '15'
default['librenms']['cron']['alerts']['enabled'] = true
default['librenms']['cron']['alerts']['hour'] = '*'
default['librenms']['cron']['alerts']['minute'] = '*'
default['librenms']['cron']['poll-billing']['enabled'] = true
default['librenms']['cron']['poll-billing']['hour'] = '*'
default['librenms']['cron']['poll-billing']['minute'] = '*/5'
default['librenms']['cron']['billing-calculate']['enabled'] = true
default['librenms']['cron']['billing-calculate']['hour'] = '*'
default['librenms']['cron']['billing-calculate']['minute'] = '01'
default['librenms']['cron']['check']['enabled'] = true
default['librenms']['cron']['check']['hour'] = '*'
default['librenms']['cron']['check']['minute'] = '*/5'

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
