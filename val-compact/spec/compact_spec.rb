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

end
