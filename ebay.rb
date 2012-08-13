require 'rubygems'
require 'bundler'
Bundler.require
require 'json'
require 'pp'

config = JSON.parse(File.open('config.json').read)

Rebay::Api.configure do |ebay|
  ebay.app_id = config['app_id']
end

finder = Rebay::Finding.new

Dir['prices/*'].each do |filename|
  json = JSON.parse(File.read(filename))
  json.each do |entry|
    File.open(File.join('auctions', entry["model_slug"]), 'w') do |f|
      f << finder.find_items_by_keywords(:keywords => entry["name"])
    end
  end
end
