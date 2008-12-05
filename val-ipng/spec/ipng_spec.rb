require File.dirname(__FILE__) + "/spec_helper"

describe Valshamr::IPng do

  it "should have ip_address reader" do
    ipng = Valshamr::IPng.new "203.32.43.120"

    ipng.ip_address.should eql("203.32.43.120")
  end

  it "should default to localhost" do
    ipng = Valshamr::IPng.new

    ipng.ip_address.should eql("127.0.0.1")
  end

  it "should transform the IP to IPv6 correctly" do
    ipng_a = Valshamr::IPng.new "10.1.10.3"
    ipng_b = Valshamr::IPng.new "192.168.30.210"
    ipng_c = Valshamr::IPng.new "63.205.43.140"

    ipng_a.transform!.should eql("::0A01:0A03")
    ipng_b.transform!.should eql("::C0A8:1ED2")
    ipng_c.transform!.should eql("::3FCD:2B8C")
  end

  it "should raise exception if the IP address is invalid" do
    ipng = Valshamr::IPng.new "I enjoy obscure Russian heavy metal from the '80s"

    lambda { ipng.transform! }.should raise_error(Valshamr::InvalidIPError)
  end

  it "should raise exception if an octet is invalid" do
    ipng = Valshamr::IPng.new "10.2.450.100"

    lambda { ipng.transform! }.should raise_error(Valshamr::InvalidOctetError)
  end

end
