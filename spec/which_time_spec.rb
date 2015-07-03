require 'spec_helper'

describe WhichTime do

  it "developer should be able to create instance :)" do
    whichtime = WhichTime.new('Lviv, UA', "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE")

    expect( whichtime.address ).to eq('Lviv, UA')
  end

  it "get coordinates from location" do
    whichtime = WhichTime.new("Kyiv, str. Khmelnitskogo 3, pub 'Naturlih'", "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE")

    expect( whichtime.location.class.to_s ).to eq('Hash')
    expect( whichtime.location ).to eq({"lat"=>50.4501, "lng"=>30.5234})
  end

  it "get time by location" do
    t1 = Time.now
    t2 = WhichTime.in("Kyiv, str. Khmelnitskogo 3, pub 'Naturlih'", "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE")
    t3 = Time.now

    #binding.pry
    expect(t1 <= t2).to be_truthy
    expect(t3 >= t2).to be_truthy
  end

end
