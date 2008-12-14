require File.dirname(__FILE__) + "/spec_helper"

describe Valshamr::ToBinary do

  it "should have ip_address reader" do
    val_to_binary = Valshamr::ToBinary.new "1080:900:CDDC:0:0:0:C0A8:1ED2"

    val_to_binary.ip_address.should eql("1080:900:CDDC:0:0:0:C0A8:1ED2")
  end

  it "should default to localhost" do
    val_to_binary = Valshamr::ToBinary.new

    val_to_binary.ip_address.should eql("0:0:0:0:0:0:0:1")
  end

  it "should generate binary representations of valid IPv6 addresses and default to 32 bits per line" do
    val_to_binary = Valshamr::ToBinary.new "1080:900:CDDC:0:0:0:C0A8:1ED2"

    binary_data = "0001 0000 1000 0000 0000 1001 0000 0000\n1100 1101 1101 1100 0000 0000 0000 0000\n0000 0000 0000 0000 0000 0000 0000 0000\n1100 0000 1010 1000 0001 1110 1101 0010"
    val_to_binary.transform.should eql(binary_data)
  end

  describe "when generating bits on multiple lines" do
    before do
      @val_to_binary = Valshamr::ToBinary.new "1080:900:CDDC:0:0:0:C0A8:1ED2"
    end

    it "should generate binary on one line" do
      one_line = "0001 0000 1000 0000 0000 1001 0000 0000 1100 1101 1101 1100 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 1100 0000 1010 1000 0001 1110 1101 0010"
      @val_to_binary.transform(128).should eql(one_line)
    end

    it "should generate binary on two lines" do
      two_lines = "0001 0000 1000 0000 0000 1001 0000 0000 1100 1101 1101 1100 0000 0000 0000 0000\n0000 0000 0000 0000 0000 0000 0000 0000 1100 0000 1010 1000 0001 1110 1101 0010"
      @val_to_binary.transform(64).should eql(two_lines)
    end

    it "should generate binary on four lines" do
      four_lines = "0001 0000 1000 0000 0000 1001 0000 0000\n1100 1101 1101 1100 0000 0000 0000 0000\n0000 0000 0000 0000 0000 0000 0000 0000\n1100 0000 1010 1000 0001 1110 1101 0010"
      @val_to_binary.transform(32).should eql(four_lines)
    end

    it "should generate binary on eight lines" do
      eight_lines = "0001 0000 1000 0000\n0000 1001 0000 0000\n1100 1101 1101 1100\n0000 0000 0000 0000\n0000 0000 0000 0000\n0000 0000 0000 0000\n1100 0000 1010 1000\n0001 1110 1101 0010"
      @val_to_binary.transform(16).should eql(eight_lines)
    end
  end

  it "should raise exception if an invalid address is supplied" do
    val_to_binary = Valshamr::ToBinary.new "This is not an IP address!"

    lambda { val_to_binary.transform }.should raise_error(Valshamr::InvalidIPv6Error)
  end

  it "should raise exception if an invalid bits_per_line parameter was supplied" do
    val_to_binary = Valshamr::ToBinary.new "1080:900:CDDC:0:0:0:C0A8:1ED2"

    lambda { val_to_binary.transform(900) }.should raise_error(Valshamr::InvalidBitCount)
    lambda { val_to_binary.transform(6) }.should raise_error(Valshamr::InvalidBitCount)
    lambda { val_to_binary.transform(37) }.should raise_error(Valshamr::InvalidBitCount)
  end

end
