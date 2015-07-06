%W( which_time/version net/http uri net/http json tzinfo active_support/time).each{ |lib| require lib }

class WhichTime

  def initialize address, api_key, time=Time.now
    @address, @api_key, @timestamp = address.gsub(' ','+'), api_key, time.to_i
  end

  def location
    @location ||= get_location['results'][0]['geometry']['location']
  end

  def coordinates
    location.values.join(',')
  end

  def timezone
    @timezone ||= get_timezone['timeZoneId']
  end

  def time
    Time.at(@timestamp).in_time_zone timezone
  end

  def self.in address, api_key, time=Time.new
    new(address, api_key, time).time
  end

  private

  def request type, params
    Net::HTTP.get URI.parse("https://maps.googleapis.com/maps/api/#{type}/json?#{URI.encode_www_form(params)}")
  end

  def response type, params
    JSON.parse request(type, params)
  end

  def get_location 
    response 'geocode', address: @address, key: @api_key
  end

  def get_timezone
    response 'timezone', timestamp: @timestamp, location: coordinates, key: @api_key
  end

end
