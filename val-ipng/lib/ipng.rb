class Valshamr::IPng

  attr_reader :ip_address

  def initialize(ip_address = "127.0.0.1")
    @ip_address = ip_address.to_s
  end

  def transform!
    unless is_valid_address?
      raise Valshamr::InvalidIPError, "Expected IPv4 address in the form of x[xx].x[xx].x[xx].x[xx], but received: #{@ip_address}"
    end

    octets = @ip_address.split "."
    octets.map! { |octet| convert_octet_to_hexadecimal octet }

    "::#{octets.join(':')}"
  end

  private

  def is_valid_address?
    @ip_address =~ /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  end

  def is_valid_octet?(octet)
    (0..255).include? octet.to_i
  end

  def convert_octet_to_hexadecimal(octet)
    unless is_valid_octet? octet
      raise Valshamr::InvalidOctetError, "Expected octet in the range of 0..255, but received: #{octet}"
    end

    "FF"
  end

end

class Valshamr::InvalidIPError < Exception; end
class Valshamr::InvalidOctetError < Exception; end
