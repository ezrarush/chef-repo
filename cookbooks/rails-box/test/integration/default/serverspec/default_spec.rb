require 'spec_helper'

describe 'rails-box::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html

  it 'does something' do
    skip 'Replace this with meaningful tests'
  end
end

describe package('libsqlite3-dev') do
  it { should be_installed }
end
