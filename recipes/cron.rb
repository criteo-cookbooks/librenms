#
# Cookbook:: librenms
# Recipe:: cron
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# cron mgmt to be able to disable them one by one if not wanted.

# TODO : set the frequencies as attributes

librenms_homedir = ::File.join(node['librenms']['root_dir'], 'librenms')
librenms_username = node['librenms']['user']

cron 'discovery all' do
  command "#{librenms_homedir}/discovery.php -h all >> /dev/null 2>&1"
  hour node['librenms']['cron']['discovery_all']['hour']
  minute node['librenms']['cron']['discovery_all']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['discovery_all']['enabled'] }
end

cron 'discover new' do
  command "#{librenms_homedir}/discovery.php -h new >> /dev/null 2>&1"
  hour node['librenms']['cron']['discovery_new']['hour']
  minute node['librenms']['cron']['discovery_new']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['discovery_new']['enabled'] }
end

cron 'poller wrapper' do
  command "#{librenms_homedir}/cronic #{librenms_homedir}/poller-wrapper.py #{node['librenms']['config']['poller_threads']}"
  hour node['librenms']['cron']['poller']['hour']
  minute node['librenms']['cron']['poller']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['poller']['enabled'] }
end

cron 'daily' do
  command "#{librenms_homedir}/daily.sh >> /dev/null 2>&1"
  hour node['librenms']['cron']['daily']['hour']
  minute node['librenms']['cron']['daily']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['daily']['enabled'] }
end

cron 'alerts' do
  command "#{librenms_homedir}/alerts.php >> /dev/null 2>&1"
  hour node['librenms']['cron']['alerts']['hour']
  minute node['librenms']['cron']['alerts']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['alerts']['enabled'] }
end

cron 'poll billing' do
  command "#{librenms_homedir}/poll-billing.php >> /dev/null 2>&1"
  hour node['librenms']['cron']['poll-billing']['hour']
  minute node['librenms']['cron']['poll-billing']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['poll-billing']['enabled'] }
end

cron 'billing calculate' do
  command "#{librenms_homedir}/billing-calculate.php >> /dev/null 2>&1"
  hour node['librenms']['cron']['billing-calculate']['hour']
  minute node['librenms']['cron']['billing-calculate']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['billing-calculate']['enabled'] }
end

cron 'check services' do
  command "#{librenms_homedir}/check-services.php >> /dev/null 2>&1"
  hour node['librenms']['cron']['check']['hour']
  minute node['librenms']['cron']['check']['minute']
  user librenms_username
  only_if { node['librenms']['cron']['check']['enabled'] }
end
