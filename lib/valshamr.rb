# Application root.
# Sets up the namespace, shared logic, exception classes and starts the loading sequence.

module Valshamr

  # These are very slack implementations.
  # Feel free to improve them.

  def is_valid_expanded_ipv6_address?
    (@ip_address =~ /^[a-fA-F0-9\:]{15,39}$/ and !@ip_address.include? "::")
  end

  def is_valid_compacted_ipv6_address?
    (@ip_address =~ /^[a-fA-F0-9\:]{3,37}$/ and @ip_address.include? "::")
  end

end

class Valshamr::InvalidIPv6Error < Exception; end
class Valshamr::InvalidIPv4Error < Exception; end
class Valshamr::InvalidDecimalOctetError < Exception; end
class Valshamr::InvalidBitCount < Exception; end

require File.join(File.dirname(__FILE__), '../val-ipng/lib/ipng')
require File.join(File.dirname(__FILE__), '../val-expand/lib/expand')
require File.join(File.dirname(__FILE__), '../val-compact/lib/compact')
require File.join(File.dirname(__FILE__), '../val-to-binary/lib/to_binary')
