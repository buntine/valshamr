#! /usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../lib/valshamr')
require 'fcntl'
require 'optparse'

bits_per_line = 32
shown = false

# Parse the supplied options.
OptionParser.new do |opts|
  opts.banner = "Usage: to_binary.rb [options] [address(es)]"

  opts.on("-b", "--bits N", "Display the data with N bits per line") do |bits|
    bits_per_line = bits.to_i
  end
end.parse!

addresses = ARGV

# Read in from stdin if there is something there.
if STDIN.fcntl(Fcntl::F_GETFL, 0) == 0
  addresses.concat STDIN.readlines.map { |line| line.sub /\n$/, '' }
end

#  each given IP address.
addresses.each do |ip_address|
  to_binary = Valshamr::ToBinary.new ip_address

  begin
    puts "-" * 10 if shown; shown = true

    puts to_binary.transform(bits_per_line)
  rescue Valshamr::InvalidIPv6Error, Valshamr::InvalidBitCount
     puts "ERROR: #{$!.message}"
     exit 1
  end
end
