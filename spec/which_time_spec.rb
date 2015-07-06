require 'spec_helper'
require 'pry'

describe WhichTime do

  let(:address)  { "Kyiv, str. Khmelnitskogo 3, pub 'Naturlih'" }
  let(:api_key)  { "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE"    }
  let(:sometime) { Time.utc(2015, 7, 5, 9, 10)  }

  let(:whichtime) { WhichTime.new( address, api_key, sometime ) }

  it "should be whichtime object with correct instance variables" do
    expect( whichtime.instance_variable_get("@address")   ).to eq( "Kyiv,+str.+Khmelnitskogo+3,+pub+'Naturlih'" )
    expect( whichtime.instance_variable_get("@api_key")   ).to eq( "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE"    )
    expect( whichtime.instance_variable_get("@timestamp") ).to eq( sometime.to_i                                    )
  end

  it "should be correct request to Google geocode API" do
    geocode = whichtime.send :request, 'geocode', address: address, key: api_key
    expect( geocode.class.to_s ).to eq( "String" )
    
    expect( geocode ).to include( "results"            )
    expect( geocode ).to include( "address_components" )
    expect( geocode ).to include( "geometry"           )
    expect( geocode ).to include( "southwest"          )
    expect( geocode ).to include( "place_id"           )
    expect( geocode ).to include( "partial_match"      )
    expect( geocode ).to include( "status"             )
  end

  it "should be correct response to Google geocode API" do
    geocode = whichtime.send :response, 'geocode', address: address, key: api_key
    expect( geocode.class.to_s ).to eq( "Hash" )
    expect( geocode['status']  ).to eq( "OK"   ) 
  end

  it "should be correct search for geolocation" do
    geolocation = whichtime.send :get_location
    expect( geolocation['results'][0]['geometry']['location'] ).to eq({"lat"=>50.4501, "lng"=>30.5234})
  end

  it "should return correct location" do
    location = whichtime.location
    expect( whichtime.instance_variable_get("@location") ).to eq({"lat"=>50.4501, "lng"=>30.5234})
    expect( location ).to eq({"lat"=>50.4501, "lng"=>30.5234})
  end

  it "should return correct coordinates" do
    expect( whichtime.coordinates ).to eq( "50.4501,30.5234" )
  end

  it "should be correct response to Google timezone API" do
    timezone = whichtime.send :response, 'timezone', timestamp: sometime.to_i, location: "50.4501,30.5234", key: api_key
    expect( timezone.class.to_s ).to eq( "Hash" )
    
    expect( timezone['status']       ).to eq( "OK" )
    expect( timezone['dstOffset']    ).to eq( 3600 )
    expect( timezone['timeZoneId']   ).to eq( "Europe/Kiev" )
    expect( timezone['timeZoneName'] ).to eq( "Eastern European Summer Time")
  end

  it "should return correct timezone" do
    expect( whichtime.timezone ).to eq( "Europe/Kiev" )
  end

  it "should return correct time" do
    expect( whichtime.time.strftime("%Y-%m-%d %H:%M:%S") ).to eq( sometime.strftime("%Y-%m-%d %H:%M:%S") )
  end

  it "should return correct time by address" do
    result = WhichTime.in(address, api_key, sometime)
    expect( result.strftime("%Y-%m-%d %H:%M:%S") ).to eq( sometime.strftime("%Y-%m-%d %H:%M:%S") )
  end

end
