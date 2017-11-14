source 'http://nexus-par.criteo.prod/content/groups/rubygems/'
# Common gems for development and testing:
gem 'goag'
gem 'kitchen-transport-speedy'
group :ec2 do
  gem 'test-kitchen'
  gem 'kitchen-ec2', git: 'https://github.com/criteo-forks/kitchen-ec2.git', branch: 'criteo'
  gem 'winrm',       '>= 1.6'
  gem 'winrm-fs',    '>= 0.3'
  gem 'dotenv'
end

# Other gems should go after this comment
gem 'rubocop', '=0.50.0'
