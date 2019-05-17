# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'uri'
require 'json'

Brewery.destroy_all

uri = URI.parse("https://api.openbrewerydb.org/breweries?page=1&per_page=50")
request = Net::HTTP::Get.new(uri)
request.content_type = "application/json"

req_options = {
  use_ssl: uri.scheme == "https",
}

@response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

puts @response.body
puts @response.message
puts @response.code

info = @response.body

info.force_encoding("utf-8")

File.write('breweries.json', info)

puts "file created successfully"

file = File.read('breweries.json')

breweries = JSON.load(file)

breweries.each do |b|
  Brewery.create(
    :name => b['name'],
    :brewery_type => b['brewery_type'],
    :street => b['street'],
    :city => b['city'],
    :state => b['state'],
    :postal_code => b['postal_code'],
    :country => b['country'],
    :longitude => b['longitude'],
    :latitude => b['latitude'],
    :phone => b['phone'],
    :website_url => b['website_url']
  )
end
