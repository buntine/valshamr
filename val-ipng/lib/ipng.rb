class Valshamr::IPng

  attr_reader :ip_address

  def initialize(ip_address = "127.0.0.1")
    @ip_address = ip_address
  end

  def transform!
    unless is_valid_ip?
      raise Valshamr::InvalidIPError "Expected IPv4 address in the form of xxx.xxx.xxx.xxx, but received #{@ip_address}"
    end

    octets = @ip_address.split "."
    octets.map! { |octet| convert_octet_to_hexadecimal octet }

    "::#{octets.join(':')}"
  end

  private

  def is_valid_ip?
    true
  end

  def is_valid_octet?(octet)
    true
  end

  def convert_octet_to_hexadecimal(octet)
    "FF"
  end

end

class Valshamr::InvalidIPError < Exception; end
class Valshamr::InvalidOctetError < Exception; end
