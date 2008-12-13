
# This class is part of the Valshamr software suite.
# It will transform a valid IPv6 address from full-form into it's binary equivalent.

class Valshamr::ToBinary

  attr_reader :ip_address

  def initialize(ip_address = "0:0:0:0:0:0:0:1")
    @ip_address = ip_address.to_s
  end

  def transform(bits_per_line=32)
    unless is_valid_expanded_ipv6_address?
      raise Valshamr::InvalidIPv6Error, "Expected expanded IPv6 address (e.g FF11:0:0:0:0:8:CD09:1F0A), but received: #{@ip_address}."
    end

    unless (8..128).include?(bits_per_line) and bits_per_line % 8 == 0
      raise Valshamr::InvalidBitCount, "Bits per line must be between 8 and 128 and be a multiple of 8."
    end

  end

  private

  # This is a very slack implementation.
  # Feel free to improve it.
  def is_valid_expanded_ipv6_address?
    (@ip_address =~ /^[a-fA-F0-9\:]{15,39}$/ and !@ip_address.include? "::")
  end
end

class Valshamr::InvalidIPv6Error < Exception; end
class Valshamr::InvalidBitCount < Exception; end
