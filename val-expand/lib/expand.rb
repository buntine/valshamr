
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

    ip = [""] * 8
    left, right = @ip_address.split "::", 2

    # Place the left-hand octets in their appropriate positions.
    unless left.empty?
      left_octets = left.split ":"
      left_octets.each_with_index { |slice, index| ip[index] = slice }
    end

    # Place the right-hand octets in their appropriate positions (reverse order).
    unless right.empty?
      right_octets = right.split ":"
      right_octets.reverse!
      right_octets.each_with_index { |slice, index| ip[7 - index] = slice }
    end

    # Finally, anything left over in the middle must be a zero.
    ip.map! { |octet| octet.empty? ? "0" : octet }

    # Pad each octet with leading zeroes, if necessary.
    if length.eql? :long
      ip.map! { |octet| octet.insert(0, "0" * (4 - octet.length)) }
    end

    ip.join ":"
  end

  private

  # This is a very slack implementation.
  # Feel free to improve it.
  def is_valid_ipv6_address?
    (@ip_address =~ /^[a-fA-F0-9\:]{3,37}$/ and @ip_address.include? "::")
  end

end

class Valshamr::InvalidIPv6Error < Exception; end
