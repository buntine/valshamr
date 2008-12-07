#! /usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../lib/valshamr')
require 'fcntl'
require 'optparse'

length = :short

# Parse the supplied options.
OptionParser.new do |opts|
  opts.banner = "Usage: expand.rb [options] [address(es)]"

  opts.on("-l", "--long", "Fully expand the address") do
    length = :long
  end
end.parse!

addresses = ARGV

# Read in from stdin if there is something there.
if STDIN.fcntl(Fcntl::F_GETFL, 0) == 0
  addresses.concat STDIN.readlines.map { |line| line.sub /\n$/, '' }
end

# Expand each given IP address.
addresses.each do |ip_address|
  expander = Valshamr::Expand.new ip_address

  begin
    puts expander.expand(length)
  rescue => e
     exit 1
     raise e
  end
end
