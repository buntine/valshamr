
# This class is part of the Valshamr software suite.
# It will transform a valid IPv6 address from double-colon notation to it's full form.

class Valshamr::Expand

  attr_reader :ip_address

  def initialize(ip_address = "::1")
    @ip_address = ip_address.to_s
  end

  def expand(length = :short)
    unless is_valid_ipv6_address?
      raise Valshamr::InvalidIPv6Error, "Expected compacted IPv6 address (e.g ::8:CD09:1F0A), but received: #{@ip_address}"
    end

    "Incomplete"
  end

  private

  # This is a very slack implementation.
  # Feel free to improve it.
  def is_valid_ipv6_address?
    (@ip_address =~ /^[a-fA-F0-9\:]{3,37}$/ and @ip_address.include? "::")
  end

end

class Valshamr::InvalidIPv6Error < Exception; end
class Valshamr::InvalidHexadecimalOctetError < Exception; end
