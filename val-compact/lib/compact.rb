
# This class is part of the Valshamr software suite.
# It will transform a valid IPv6 address from full-form into it's double-colon notation equivalent.

class Valshamr::Compact

  attr_reader :ip_address

  def initialize(ip_address = "0:0:0:0:0:0:0:1")
    @ip_address = ip_address.to_s
  end

end
