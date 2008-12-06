class Valshamr::IPng

  attr_reader :ip_address

  def initialize(ip_address = "127.0.0.1")
    @ip_address = ip_address.to_s
  end

  def transform!
    unless is_valid_ipv4_address?
      raise Valshamr::InvalidIPError, "Expected IPv4 address in the form of x[xx].x[xx].x[xx].x[xx], but received: #{@ip_address}"
    end

    octets = @ip_address.split "."
    octets.map! { |octet| convert_decimal_octet_to_hexadecimal octet }

    new_ip = construct_hexadecimal_octets octets

    "::#{new_ip}"
  end

  private

  def is_valid_ipv4_address?
    @ip_address =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  end

  def is_valid_decimal_octet?(octet)
    (0..255).include? octet.to_i
  end

  def convert_decimal_octet_to_hexadecimal(octet)
    unless is_valid_decimal_octet? octet
      raise Valshamr::InvalidOctetError, "Expected octet in the range of 0..255, but received: #{octet}"
    end

    "FF"
  end

  def construct_hexadecimal_octets(octets)
    octet_group = []

    octets.each_slice(2) do |slice|
      octet_group << slice.join
    end

    octet_group.join ":"
  end

end

class Valshamr::InvalidIPError < Exception; end
class Valshamr::InvalidOctetError < Exception; end
