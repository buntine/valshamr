require File.dirname(__FILE__) + "/spec_helper"

describe Valshamr::Expand do

  it "should have ip_address reader" do
    ipng = Valshamr::Expand.new "::C0A8:1ED2"

    ipng.ip_address.should eql("::C0A8:1ED2")
  end

  it "should default to localhost" do
    ipng = Valshamr::Expand.new

    ipng.ip_address.should eql("::1")
  end


end
