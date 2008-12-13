
# This class is part of the Valshamr software suite.
# It will transform a valid IPv6 address from double-colon notation to it's full form.

class Valshamr::Expand

  attr_reader :ip_address

  def initialize(ip_address = "::1")
    @ip_address = ip_address.to_s
  end

  def expand(length = :short)
    unless is_valid_compacted_ipv6_address?
      raise Valshamr::InvalidIPv6Error, "Expected compacted IPv6 address (e.g ::8:CD09:1F0A), but received: #{@ip_address}."
    end

    ip = [""] * 8
    left, right = @ip_address.split "::", 2

    # Place the left-hand portions in their appropriate positions.
    unless left.empty?
      left_portions = left.split ":"
      left_portions.each_with_index { |slice, index| ip[index] = slice }
    end

    # Place the right-hand portions in their appropriate positions (reverse order).
    unless right.empty?
      right_portions = right.split ":"
      right_portions.reverse!
      right_portions.each_with_index { |slice, index| ip[7 - index] = slice }
    end

    # Finally, anything left over in the middle must be a zero.
    ip.map! { |portion| portion.empty? ? "0" : portion }

    # Pad each portion with leading zeroes, if necessary.
    if length.eql? :long
      ip.map! { |portion| portion.insert(0, "0" * (4 - portion.length)) }
    end

    ip.join ":"
  end

  private

  # This is a very slack implementation.
  # Feel free to improve it.
  def is_valid_compacted_ipv6_address?
    (@ip_address =~ /^[a-fA-F0-9\:]{3,37}$/ and @ip_address.include? "::")
  end

end

class Valshamr::InvalidIPv6Error < Exception; end
