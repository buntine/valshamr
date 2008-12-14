
# This class is part of the Valshamr software suite.
# It will transform a valid, full-formed IPv6 address into it's binary equivalent.

class Valshamr::ToBinary
  include Valshamr

  attr_reader :ip_address

  def initialize(ip_address = "0:0:0:0:0:0:0:1")
    @ip_address = ip_address.to_s
  end

  def transform(bits_per_line=32)
    unless is_valid_expanded_ipv6_address?
      raise Valshamr::InvalidIPv6Error, "Expected expanded IPv6 address (e.g FF11:0:0:0:0:8:CD09:1F0A), but received: #{@ip_address}."
    end

    unless is_valid_bit_count? bits_per_line
      raise Valshamr::InvalidBitCount, "Bits per line must be 16 (eight lines), 32 (four lines), 64 (two lines) or 128 (one line)"
    end

    chunks = @ip_address.split ":"

    # Generate 16-bit chunks and break into parts.
    chunks.map! do |chunk|
      bits = chunk.hex.to_s(base=2).rjust(16, "0")
      (1..3).each { |x| bits.insert(-(x*4)-x, " ") }
      bits
    end

    binary_data = chunks.join " "

    # Add in newlines at the appropriate positions. There has GOT to be a
    # better way of doing this. Please enlighten me.
    (1..(128 / bits_per_line)-1).each do |line|
      block = line * bits_per_line
      spaces = (block / 4) - 1

      binary_data[block + spaces, 1] = "\n"
    end

    binary_data
  end

  private

  def is_valid_bit_count?(bits)
    [16, 32, 64, 128].include? bits.to_i
  end
end
