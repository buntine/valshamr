require File.dirname(__FILE__) + "/spec_helper"

describe Valshamr::Expand do

  it "should have ip_address reader" do
    val_expander = Valshamr::Expand.new "::C0A8:1ED2"

    val_expander.ip_address.should eql("::C0A8:1ED2")
  end

  it "should default to localhost" do
    val_expander = Valshamr::Expand.new

    val_expander.ip_address.should eql("::1")
  end

  it "should expand address into it's semi-expanded form" do
    val_expander_a = Valshamr::Expand.new "1080::8:C0A8:1ED2"
    val_expander_b = Valshamr::Expand.new "1010:8::CD11:C0A8:1ED2"
    val_expander_c = Valshamr::Expand.new "::F0A8:7EC4"
    val_expander_d = Valshamr::Expand.new

    val_expander_a.expand.should eql('1080:0:0:0:0:8:C0A8:1ED2')
    val_expander_b.expand.should eql('1010:8:0:0:0:CD11:C0A8:1ED2')
    val_expander_c.expand.should eql('0:0:0:0:0:0:F0A8:7EC4')
    val_expander_d.expand.should eql('0:0:0:0:0:0:0:1') # This is localhost.
  end

  it "should expand address into it's fully-expanded form" do
    val_expander_a = Valshamr::Expand.new "1080::8:C0A8:1ED2"

    val_expander_a.expand(:long).should eql('1080:0000:0000:0000:0000:0008:C0A8:1ED2')
  end

  it "should raise exception if an invalid address is supplied" do
    val_expander = Valshamr::Expand.new "This is not an IP address!"

    lambda { val_expander.expand }.should raise_error(Valshamr::InvalidIPv6Error)
  end

  it "should raise exception if a valid, but full-formed address is supplied" do
    val_expander = Valshamr::Expand.new "1080:0:0:0:0:8:C0A8:1ED2"

    lambda { val_expander.expand }.should raise_error(Valshamr::InvalidIPv6Error)
  end

end
