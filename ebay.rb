require 'rubygems'
require 'bundler'
Bundler.require
require 'json'

config = JSON.parse(File.open('config.json').read)

Ebay::Api.configure do |ebay|
  ebay.auth_token = config['auth_token']
  ebay.app_id = config['app_id']
  ebay.dev_id = config['dev_id']
  ebay.cert = config['cert']
  ebay.use_sandbox = true
end

client = Ebay::Api.new
