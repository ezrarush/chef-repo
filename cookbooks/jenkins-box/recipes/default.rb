include_recipe 'apt'

package 'git'

include_recipe 'iptables'
iptables_rule 'http'
iptables_rule 'ssh'

include_recipe 'jenkins::master'

include_recipe 'jenkins-box::nginx'

template "/var/lib/jenkins/.gitconfig" do
  source "gitconfig.erb"
end

template "/var/lib/jenkins/my_database.yml" do
  source "my_database.yml"
end

include_recipe 'jenkins-box::ruby'
include_recipe 'nodejs'

# jenkins_plugin 'greenballs' do

jenkins_plugin 'ruby-runtime' do
  notifies :restart, 'service[jenkins]', :delayed
end

jenkins_plugin 'rvm' do
  notifies :restart, 'service[jenkins]', :deplayed
end

jenkins_plugin 'git'
jenkins_plugin 'github'
jenkins_plugin 'rake'

template "/var/tmp/run_tests.xml" do
  source 'run_tests.xml'
end

jenkins_job "run_test" do
  action :create
  config "/var/tmp/run_tests.xml"
end

jenkins_command 'safe-restart'
