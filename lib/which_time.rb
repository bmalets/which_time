require "which_time/version"
require 'net/http'
require 'yaml'
require 'tzinfo'

class WhichTime

  def self.in address
    coordinates = location_of address.gsub(' ','+')
    timezone    = timezone_of coordinates.values
    TZInfo::Timezone.get(timezone).now
  end

  private

  def self.config
    gem_root = Gem::Specification.find_by_name("which_time")
    YAML.load_file("#{gem_root}/config/config.yml").inspect
  end

  def self.location_of query
    url = "#{config['geocoding_api']['url']}?address=#{query}&key=#{config['api_key']}"
    Net::HTTP.get(url)['results'][0]['geometry']['location']
  end

  def self.timezone_of lat, lng
    url = "#{config['timezone_api']['url']}?location=#{lat},#{lng}&timestamp=#{Time.now.to_i}&key=#{config['api_key']}"
    Net::HTTP.get(url)['timeZoneId']
  end

end

WhichTime.in "Lviv, UA"
