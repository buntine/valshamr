#! /usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../lib/valshamr')
require 'fcntl'
require 'optparse'

# Supplies a help massage on -h/--help.
OptionParser.new do |opts|
  opts.banner = "Usage: ipng.rb [address(es)]"
end.parse!

addresses = ARGV

# Read in from stdin if there is something there.
if STDIN.fcntl(Fcntl::F_GETFL, 0) == 0
  addresses.concat STDIN.readlines.map { |line| line.sub /\n$/, '' }
end

# Convert each given IP address.
addresses.each do |ip_address|
  ipng = Valshamr::IPng.new ip_address

  begin
    puts ipng.transform
  rescue Valshamr::InvalidIPv4Error, Valshamr::InvalidDecimalOctetError
     puts "ERROR: #{$!.message}"
     exit 1
  end
end
