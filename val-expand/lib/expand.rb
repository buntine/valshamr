
# This class is part of the Valshamr software suite.
# It will transform a valid IPv6 address from double-colon notation to it's full form.

class Valshamr::Expand

  attr_reader :ip_address

  def initialize(ip_address = "::1")
    @ip_address = ip_address.to_s
  end

  def expand(length = :short)

  end

end
