name             'librenms'
maintainer       'Criteo'
maintainer_email 'use_github_issues@criteo.com'
license          'All rights reserved'
description      'Installs/Configures librenms'
long_description '# librenms

[LibreNMS](http://www.librenms.org/)
Installation and configuration by chef

For now:
- CentOS and Ubuntu.
- Based on apache2.
- rrdcached support

TODO: 
 - nginx support
 - External auth (LDAP, AD, Radius, etc.)
 - SElinux support
 - Performance optimisations from LibreNMS doc
 - Worldmap support
 - poller modules support
 - all other extensions support
'
issues_url       'https://github.com/criteo-cookbooks/librenms/issues'
source_url       'https://github.com/criteo-cookbooks/librenms'
version          '0.1.0'
supports         'centos7'
supports         'centos'
depends          'apache2'
depends          'logrotate'
