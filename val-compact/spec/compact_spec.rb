require File.dirname(__FILE__) + "/spec_helper"

describe Valshamr::Compact do

  it "should have ip_address reader" do
    val_compactor = Valshamr::Compact.new "1080:900:CDDC:0:0:0:C0A8:1ED2"

    val_compactor.ip_address.should eql("1080:900:CDDC:0:0:0:C0A8:1ED2")
  end

  it "should default to localhost" do
    val_compactor = Valshamr::Compact.new

    val_compactor.ip_address.should eql("0:0:0:0:0:0:0:1")
  end

  it "should compact valid IPv6 addresses to their shortest form" do
    val_compactor_a = Valshamr::Compact.new "1080:900:CDDC:0:0:0:C0A8:1ED2"
    val_compactor_b = Valshamr::Compact.new "10AB:0080:0:0:0:0:C0A8:10DC"
    val_compactor_c = Valshamr::Compact.new "0000:0000:0000:0000:0000:0000:FF11:DD22"
    val_compactor_d = Valshamr::Compact.new

    val_compactor_a.compact.should eql("1080:900:CDDC::C0A8:1ED2")
    val_compactor_b.compact.should eql("10AB:80::C0A8:1ED2")
    val_compactor_c.compact.should eql("::FF11:DD22")
    val_compactor_d.compact.should eql("::1")
  end

  it "should raise exception if an invalid address is supplied" do
    val_compactor = Valshamr::Compact.new "This is not an IP address!"

    lambda { val_compactor.compact }.should raise_error(Valshamr::InvalidIPv6Error)
  end

  it "should raise exception if a valid but compacted address is supplied" do
    val_compactor = Valshamr::Compact.new "1080::8:CD20:00FF"

    lambda { val_compactor.compact }.should raise_error(Valshamr::InvalidIPv6Error)
  end

end
