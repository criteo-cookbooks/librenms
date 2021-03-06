name             'librenms'
maintainer       'Criteo'
maintainer_email 'use_github_issues@criteo.com'
license          'Apache-2.0'
description      'Installs/Configures librenms'
long_description 'This cookbook installs and configure LibreNMS along with the required components (Apache and MySQL). LibreNMS is an autodiscovering PHP/MySQL-based network monitoring system.'
issues_url       'https://github.com/criteo-cookbooks/librenms/issues'
source_url       'https://github.com/criteo-cookbooks/librenms'
version          '0.2.29'
chef_version     '>= 12.14.34'
supports         'centos7'
supports         'centos'
depends          'apache2'
depends          'logrotate'
depends          'yum-epel'
depends          'ark'
depends          'facl'
depends          'poise-python'
