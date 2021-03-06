require 'rubygems'
require 'bundler'
Bundler.require

counter = 0
File.open('supported-cams.txt') do |f|
  f.each_line do |line|
    line.chomp!
    json = HTTParty.get('http://priceonomics.com/api/v1/search/', {:query => {:query => line}})
    (!json['results'].empty?) && File.open("prices/#{counter}.txt", 'w') do |w|
      w << json['results'].to_json
      puts counter
    end
    counter += 1
  end
end
