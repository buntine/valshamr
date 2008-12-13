#! /usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../lib/valshamr')
require 'fcntl'
require 'optparse'

length = :short

# Parse the supplied options.
OptionParser.new do |opts|
  opts.banner = "Usage: compact.rb [address(es)]"

  opts.on("-t", "--tiny", "Compact the address to double-colon notation") do
    length = :tiny
  end
end.parse!

addresses = ARGV

# Read in from stdin if there is something there.
if STDIN.fcntl(Fcntl::F_GETFL, 0) == 0
  addresses.concat STDIN.readlines.map { |line| line.sub /\n$/, '' }
end

# Compact each given IP address.
addresses.each do |ip_address|
  compactor = Valshamr::Compact.new ip_address

  begin
    puts compactor.compact(length)
  rescue Valshamr::InvalidIPv6Error
     puts "ERROR: #{$!.message}"
     exit 1
  end
end
