# Application root.
# Sets up the namespace and starts the loading sequence.

module Valshamr; end

require File.join(File.dirname(__FILE__), '../val-ipng/lib/ipng')
require File.join(File.dirname(__FILE__), '../val-expand/lib/expand')
require File.join(File.dirname(__FILE__), '../val-compact/lib/compact')
