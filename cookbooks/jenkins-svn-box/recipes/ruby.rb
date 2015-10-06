include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

rbenv_ruby node['ruby_version'] do
  ruby_version node['ruby_version']
  global true
end

rbenv_gem "bundler" do
  ruby_version node['ruby_version']
end
