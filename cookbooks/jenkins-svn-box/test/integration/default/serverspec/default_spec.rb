require 'spec_helper'

describe 'jenkins-svn-box::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'does something' do
    skip 'Replace this with meaningful tests'
  end
end

describe port(80) do
  it { should be_listening }
end

describe service('jenkins') do
  it { should be_enabled }
  # it { should be_installed }
  it { should be_running }
end

describe user('jenkins') do
  it { should exist }
  it { should have_home_directory '/var/lib/jenkins' }
end
