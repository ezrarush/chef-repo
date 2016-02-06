include_recipe 'apt'
include_recipe 'nginx'
include_recipe 'htpasswd'
include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'logstash::server'

kibana_user = 'kibana'

htpasswd '/etc/nginx/htpassword' do
  user kibana_user
  password 'password'
end

kibana_user kibana_user do
  name kibana_user
  group kibana_user
  home '/opt/kibana'
  action :create
end

kibana_install 'file' do
  user kibana_user
  group kibana_user
  install_dir '/opt/kibana'
  install_type 'file'
  action :create
end

template '/opt/kibana/current/config.js' do
  source node['kibana']['config_template']
  cookbook node['kibana']['config_cookbook']
  mode '0750'
  user kibana_user
end

# link '/opt/kibana/current/app/dashboards/default.json' do
#   to 'logstash.json'
#   only_if { !File.symlink?('/opt/kibana/current/app/dashboards/default.json') }
# end

include_recipe 'runit::default'

runit_service 'kibana' do
  options(
    user: kibana_user,
    home: '/opt/kibana/current'
  )
  cookbook 'kibana_lwrp'
  subscribes :restart, '', :delayed
end

kibana_web 'kibana' do
  template_cookbook 'logger-server'
  type 'nginx'
  docroot '/opt/kibana/current'
  es_server '127.0.0.1'
end
