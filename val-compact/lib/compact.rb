
# This class is part of the Valshamr software suite.
# It will transform a valid IPv6 address from full-form into it's double-colon notation equivalent.

class Valshamr::Compact
  include Valshamr

  attr_reader :ip_address

  def initialize(ip_address = "0:0:0:0:0:0:0:1")
    @ip_address = ip_address.to_s
  end

  def compact(length=:short)
    unless is_valid_expanded_ipv6_address?
      raise Valshamr::InvalidIPv6Error, "Expected expanded IPv6 address (e.g FF11:0:0:0:0:8:CD09:1F0A), but received: #{@ip_address}."
    end

    ip = remove_leading_zeroes_from_octets

    if length.eql? :tiny
      ip.sub! /(^|:)(0:){1,}/, "::"
    end

    ip
  end

  private

  # Removes leading zeroes from each portion of the IP address.
  # I like the word "octet", even though each portion is actually 16-bit...
  def remove_leading_zeroes_from_octets
    ip = @ip_address.split ":"

    ip.map! do |octet|
      no_zeroes = octet.sub /^0+/, ""
      no_zeroes.empty? ? "0" : no_zeroes
    end

    ip.join ":"
  end
end
