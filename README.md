# librenms

[![Cookbook Version][cookbook_version]][cookbook]
[![Build Status][build_status]][build_status]

[LibreNMS](http://www.librenms.org/)
Installation and configuration by chef

## Cookbooks dependencies
* apache2
* logrotate
* yum-epel

## Platforms
The release is tested on:
* CentOS 7.x
* Ubuntu stretch/sid

## Attributes
<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['librenms']['install']['version']</code></td>
    <td>LibreNMS version to install (from github repo)</td>
    <td><code>master</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['contact']</code></td>
    <td>Contact email</td>
    <td><code>webmaster@example.com</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['web']['name']</code></td>
    <td>LibreNMS URL</td>
    <td><code>librenms.example.com</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['web']['port']</code></td>
    <td>WebUI port</td>
    <td><code>80</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['user']</code></td>
    <td>LibreNMS system user name</td>
    <td><code>librenms</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['group']</code></td>
    <td>LibreNMS system group name</td>
    <td><code>librenms</code></td>
  </tr>
  <tr>
    <td><code>node['mariadb']['user_librenms']['password']</code></td>
    <td>MariaDB user's password</td>
    <td><code>default</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['snmp']['community']</code></td>
    <td>SNMP community</td>
    <td><code>public</code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['auth_ad']['admingroup']</code></td>
    <td>Name of the AD group for admin users</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['auth_ad']['apigroup']</code></td>
    <td>Name of the AD group for api users</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['librenms']['auth_ad']['usergroup']</code></td>
    <td>Name of the AD group for read-only users</td>
    <td><code></code></td>
  </tr>
</table>

### Features
- rrdcached support
- cron management
- additional repositories (optional: EPEL, webtatic)
- AD authentication (see [LibreNMS doc pages](https://docs.librenms.org/#Extensions/Authentication/#active-directory-authentication) for details)


### TODO
- nginx support
- More external auth (LDAP, Radius, etc.)
- SElinux support
- Performance optimisations from LibreNMS doc
- Worldmap support
- poller modules support
- all other extensions support

## Author
Author:: criteo (n.grieco@criteo.com)

Copyright:: 2017, criteo


[build_status]:             https://api.travis-ci.org/criteo-cookbooks/librenms.svg?branch=master
[cookbook_version]:         https://img.shields.io/cookbook/v/librenms.svg
[cookbook]:                 https://supermarket.chef.io/cookbooks/librenms
