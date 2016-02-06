include_attribute 'java'
include_attribute 'elasticsearch'
include_attribute 'logstash'
include_attribute 'kibana_lwrp'

override['java']['jdk_version'] = '7'

override['elasticsearch'][:version]      = "1.4.1"
override['elasticsearch'][:filename]     = "elasticsearch-#{node.elasticsearch[:version]}.tar.gz"
override['elasticsearch'][:download_url] = [node.elasticsearch[:host], node.elasticsearch[:repository], node.elasticsearch[:filename]].join('/')
override['elasticsearch'][:path][:conf]  = "/usr/local/etc/elasticsearch"
override['elasticsearch'][:path][:data]  = "/mnt/data-store/elasticsearch/data"
override['elasticsearch'][:path][:logs]  = "/mnt/data-store/elasticsearch/log"

override['logstash']['instance']['default']['version']            = '1.4.2'
override['logstash']['instance']['default']['source_url']         = 'https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz'
override['logstash']['instance']['default']['checksum']           = 'd59ef579c7614c5df9bd69cfdce20ed371f728ff'
override['logstash']['instance']['default']['plugins_version']    = '1.4.2'
override['logstash']['instance']['default']['plugins_source_url'] = 'https://download.elasticsearch.org/logstash/logstash/logstash-contrib-1.4.2.tar.gz'
override['logstash']['instance']['default']['plugins_checksum']   = '9903e487c8811ba4f396cfeb29e04e2a116bfce6'

# use single file for logstash config
override['logstash']['instance']['server']['config_templates_cookbook'] = 'logger-server'
override['logstash']['instance']['server']['config_templates']          = {
  'syslog' => 'config/syslog_config.conf.erb',
  'rails' => 'config/rails_config.conf.erb',
}

override['logstash']['instance']['default']['config_templates_cookbook'] = 'logger-server'
override['logstash']['instance']['default']['config_templates']          = {
  # logstash:server always uses the default, and it cant be empty!!!
  'empty_config' => 'config/empty_config.conf.erb'
}
