name 'chef-librenms'
maintainer 'Criteo'
maintainer_email 'use_github_issues@criteo.com'
license 'All rights reserved'
description 'Installs/Configures librenms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
supports 'centos7'

source_url 'https://github.com/criteo-cookbooks/librenms' if respond_to?(:source_url)
issues_url 'https://github.com/criteo-cookbooks/librenms/issues' if respond_to?(:issues_url)

depends	'apache2'
depends	'logrotate'
