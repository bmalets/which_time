require "which_time/version"
require 'net/http'
require 'uri'
require 'tzinfo'

class WhichTime

  attr_accessor :location, :timezone

  def initialize address, api_key
    @address = address
    @api_key = api_key
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
    timezone.now
  end

  def self.in address, api_key
    whichtime = self.class.new(address, api_key)
    whichtime.time
  end

  private

  def geo_request
    url_path = 'https://maps.googleapis.com/maps/api/geocode/json'
    params   = {
      address: @address.gsub(' ','+'),
      key:     @api_key
    }
    api_request(url_path, params)
  end

  def tz_request
    url_path = 'https://maps.googleapis.com/maps/api/timezone/json'
    params   = {
      timestamp: Time.now.to_i,
      location:  "#{lat},#{lng}",
      key:       @api_key
    }
    api_request(url_path, params)
  end

  def api_request api_url, params
    url       = URI.parse(api_url)
    url.query = URI.encode_www_form(params)
    Net::HTTP.get(url)
  end

end
