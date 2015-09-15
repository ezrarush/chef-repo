include_recipe 'nginx'

# disable default site
nginx_site 'default' do
  enable false
end

# create nginx config
template "#{node.nginx.dir}/sites-available/jenkins" do
  source "jenkins.erb"
  notifies :reload, 'service[nginx]'
end

# enable site
nginx_site "jenkins" do
  enable true
  notifies :reload, 'service[nginx]'
end
