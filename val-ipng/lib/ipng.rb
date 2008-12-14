
# This class is part of the Valshamr software suite.
# It will transform a valid IPv4 address (e.g 192.168.30.210) into it's IPv6 equivelant (::C0A8:1ED2).

class Valshamr::IPng
  include Valshamr

  attr_reader :ip_address

  def initialize(ip_address = "127.0.0.1")
    @ip_address = ip_address.to_s
  end

  # Performs the actual transformation. The IPv6 address
  # is returned in double-colon notation (compact form).
  def transform
    unless is_valid_ipv4_address?
      raise Valshamr::InvalidIPv4Error, "Expected IPv4 address in the form of x[xx].x[xx].x[xx].x[xx], but received: #{@ip_address}."
    end

    octets = @ip_address.split "."
    octets.map! { |octet| convert_decimal_octet_to_hexadecimal octet.to_i }

    new_ip = construct_hexadecimal_portions octets

    "::#{new_ip}"
  end

  private

  def is_valid_ipv4_address?
    @ip_address =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  end

  def is_valid_decimal_octet?(octet)
    (0..255).include? octet.to_i
  end

  # Converts the decimal octet to base-16 (hexadecimal).
  def convert_decimal_octet_to_hexadecimal(octet)
    unless is_valid_decimal_octet? octet
      raise Valshamr::InvalidDecimalOctetError, "Expected decimal value in the range of 0..255, but received: #{octet}"
    end

    hexadecimal = octet.to_s(base=16).upcase
    hexadecimal.insert(0, "0") if hexadecimal.length == 1

    hexadecimal
  end

  # Breaks the array into two slices and joins them
  # with a colon.
  def construct_hexadecimal_portions(portions)
    portion_group = []

    portions.each_slice(2) do |slice|
      portion_group << slice.join
    end

    portion_group.join ":"
  end

end
