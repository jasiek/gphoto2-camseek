require 'json'
require 'pp'
require 'net/http'
require 'net/https'

require 'rubygems'
require 'bundler'
Bundler.require

config = JSON.parse(File.open('config.json').read)

Rebay::Api.configure do |ebay|
  ebay.app_id = config['app_id']
end

Ebay::Api.configure do |ebay|
  ebay.auth_token = 'sandbox'
  ebay.dev_id = config['dev_id']
  ebay.app_id = config['app_id']
  ebay.cert = config['cert_id']
end

client = Ebay::Api.new
pp client.get_ebay_official_time.timestamp

finder = Rebay::Finding.new

Dir['prices/*'].each do |filename|
  json = JSON.parse(File.read(filename))
  json.each do |entry|
    File.open(File.join('auctions', entry["model_slug"]), 'w') do |f|
      f << finder.find_items_by_keywords(:keywords => entry["name"])
    end
  end
end
