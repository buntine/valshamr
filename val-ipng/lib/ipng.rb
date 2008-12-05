class Valshamr::IPng

  attr_reader :ip_address

  def initialize(ip_address = "127.0.0.1")
    @ip_address = ip_address
  end

  def transform!
  end

end

class Valshamr::InvalidIPError < Exception; end
