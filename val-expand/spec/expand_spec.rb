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

    val_expander_a.expand.should eql('1080:0:0:0:0:8:C0A8:1ED2')
  end

  it "should expand address into it's fully-expanded form" do
    val_expander_a = Valshamr::Expand.new "1080::8:C0A8:1ED2"

    val_expander_a.expand.should eql('1080:0000:0000:0000:0000:0008:C0A8:1ED2')
  end

  it "should raise exception if an invalid address is supplied"
  it "should raise exception if a non-compacted address is supplied"
  it "should raise exception if an invalid octet is supplied"

end
