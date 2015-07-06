# WhichTime [![Gem Version](https://badge.fury.io/rb/which_time.svg)](http://badge.fury.io/rb/which_time)
 
>Gem which gives you a simple way to find local time (timezone) of some place, address, city, region country or any other location which you want.

## Installation

1. Create google app for your project to use Google API.
2. Enable ```Geocoding API``` and ```TimeZone API``` access for your google app.
3. Get API_KEY from settings of your google app 
   (something like ```"AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE"```). 
4. Set up your google app for work (in development mode usage of API is limited: only 2500 requests per day)
5. Add this line to your application's Gemfile:

    gem 'which_time'

And then execute:

    $ bundle

Manually:

    gem install which_time

## Usage

### 1. Get local time of some address
```
WhichTime.in( somewhere, google_api_key, your_time )
```
- "somewhere" - may be an address or some place ("Lviv city, Naykova str." or "'Naturlih' pub, Kyiv" e.g.)
- "google_api_key" - API_KEY of Google application with an access to TimeZone and Geocoding API
- "your_time" - is not mandatory (Time.now is default)

examples:
```
  WhichTime.in("Kyiv, pub 'Naturlih'", "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE")
  # => 2015-07-06 03:53:10 +0300
  WhichTime.in("Kyiv", "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE", 2.days.ago)
  # => 2015-07-04 03:53:10 +0300
```

### 2. Get local time of some address (variant 2)
```
WhichTime.new( somewhere, google_api_key, your_time ).time
# => 2015-07-06 03:53:10 +0300 
```

### 3. Get timezone of some place/address/city/country
```
WhichTime.new( somewhere, google_api_key ).timezone
```
examples:
```
  WhichTime.new("Kyiv, pub 'Naturlih'", "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE").timezone
  WhichTime.in("Kyiv", "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE").timezone
  # => "Europe/Kiev"
```

### 4. Get coordinates of some place/address/location
```
WhichTime.new( somewhere, google_api_key ).location
# => {"lat"=>50.4501, "lng"=>30.5234}
```

### 5. Get coordinates of some place/address/location (variant 2)
```
WhichTime.new( somewhere, google_api_key ).coordinates
# => "50.4501,30.5234"
```

## Contributing

1. Fork it ( https://github.com/bmalets/which_time/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
