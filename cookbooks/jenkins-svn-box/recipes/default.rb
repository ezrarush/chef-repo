include_recipe 'apt'

include_recipe 'iptables'
iptables_rule 'http'
iptables_rule 'ssh'

include_recipe "build-essential"
include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

include_recipe 'jenkins::master'

template "/var/lib/jenkins/my_database.yml" do
  source "my_database.yml"
end

include_recipe 'jenkins-svn-box::ruby'
include_recipe 'nodejs'

jenkins_plugin 'ruby-runtime' do
  notifies :restart, 'service[jenkins]', :delayed
end

jenkins_plugin 'rvm' do
  notifies :restart, 'service[jenkins]', :delayed
end

jenkins_plugin 'rake'
jenkins_plugin 'greenballs'

# template "/var/tmp/run_tests.xml" do
#   source 'run_tests.xml'
# end

# jenkins_job "run_test" do
#   action :create
#   config "/var/tmp/run_tests.xml"
# end

jenkins_command 'safe-restart'
