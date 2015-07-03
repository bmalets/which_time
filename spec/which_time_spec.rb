require 'spec_helper'
describe WhichTime do

  it "should be able to create instance" do
    whichtime = WhichTime.new('Lviv, UA', "AIzaSyCqfXRRJ1d8mCS_I0Kcs4XnaZ9KYRUrJVE")
    expect( whichtime.address ).to be 'Lviv, UA'
  end

end
