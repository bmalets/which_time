require "which_time/version"
require 'net/http'
require 'uri'
require 'json'
require 'tzinfo'

class WhichTime

  attr_accessor :location, :timezone, :address, :api_key

  GEOLOCATE_URL = 'https://maps.googleapis.com/maps/api/geocode/json'
  TIMEZONE_URL  = 'https://maps.googleapis.com/maps/api/timezone/json'

  def initialize address, api_key
    @address, @api_key = address, api_key
  end

  def location
    @location ||= geo_request['results'][0]['geometry']['location']
  end

  def lat
    location['lat']
  end

  def lng
    location['lng']
  end

  def timezone
    @timezone ||= tz_request['timeZoneId']
  end

  def time
    TZInfo::Timezone.get(timezone).now
  end

  def self.in address, api_key
    new(address, api_key).time
  end

  def geo_request
    params = {address: address.gsub(' ','+'), key: api_key}
    api_request(GEOLOCATE_URL, params)
  end

  def tz_request
    params = {timestamp: Time.now.to_i, location: "#{lat},#{lng}", key: api_key}
    api_request(TIMEZONE_URL, params)
  end

  def api_request api_url, params
    url, url.query = URI.parse(api_url), URI.encode_www_form(params)
    JSON.parse(Net::HTTP.get(url))
  end

end
