include_recipe 'apt'
include_recipe 'rails-box::ruby'
include_recipe 'nodejs'
include_recipe 'sqlite'

package 'libsqlite3-dev'
