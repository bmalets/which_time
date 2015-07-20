%W( which_time/version uri net/http json tzinfo active_support/time).each{ |lib| require lib }

class WhichTime

  def initialize address, params={api_key: nil, time: Time.now, http_proxy: nil}
    @address   = address
    @api_key   = params[:api_key]
    @timestamp = params[:time].to_i 
    @proxy     = params[:http_proxy]
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

  def self.in address, params={api_key: nil, time: Time.now, http_proxy: nil}
    new(address, params).time
  end

  def proxy_host   
    URI.parse(@proxy).host if @proxy
  end

  def proxy_port    
    URI.parse(@proxy).port if @proxy
  end

  private

  def with_proxy uri_path
    http = Net::HTTP.new('maps.googleapis.com', 443, proxy_host, proxy_port)
    http.use_ssl     = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.get( uri_path.request_uri ).body
  end

  def without_proxy uri_path
    Net::HTTP.get uri_path
  end

  def request_uri type, params
    URI.parse("https://maps.googleapis.com/maps/api/#{type}/json?#{URI.encode_www_form(params)}")
  end

  def request type, params
    send (@proxy ? 'with_proxy' : 'without_proxy'), request_uri(type, params)
  end

  def response type, params
    JSON.parse request(type, params)
  end

  def get_location 
    response 'geocode', address: @address.gsub(' ','+'), key: @api_key
  end

  def get_timezone
    begin
      response 'timezone', timestamp: @timestamp, location: coordinates, key: @api_key
    rescue
      ""
    end
  end

end
