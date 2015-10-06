include_recipe 'apt'

include_recipe 'iptables'
iptables_rule 'http'
iptables_rule 'ssh'

include_recipe 'build-essential'
include_recipe 'apache2'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

include_recipe 'jenkins::master'

template '/var/lib/jenkins/my_database.yml' do
  source 'my_database.yml'
end

include_recipe 'jenkins-svn-box::ruby'
include_recipe 'nodejs'

jenkins_plugin 'rake'
jenkins_plugin 'campfire'
jenkins_plugin 'greenballs'

# pin the plugin that needs to upgrade
# https://github.com/chef-cookbooks/jenkins/issues/122
file "var/lib/jenkins/plugins/subversion.jpi.pinned" do
  mode   '0644'
  owner  node['jenkins']['master']['user']
  group  node['jenkins']['master']['group']
  action :touch
end

jenkins_plugin 'subversion' do
  version '2.5.3'
end

jenkins_plugin 'ruby-runtime' do
  notifies :restart, 'service[jenkins]', :immediately
end

# for some reason jenkins_plugin will not restart jenkins; using jenkins_command instead
jenkins_command 'safe-restart'

jenkins_plugin 'rbenv' do
  notifies :restart, 'service[jenkins]', :immediately
end

jenkins_command 'safe-restart'

# template '/var/tmp/run_tests.xml' do
#   source 'run_tests.xml'
# end

# jenkins_job 'run_test' do
#   action :create
#   config '/var/tmp/run_tests.xml'
# end


