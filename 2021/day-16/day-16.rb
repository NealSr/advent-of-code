input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

def pull_digits(binary, length)
  return binary.slice!(0, length)
end

def parse_packets_by_num_bits(binary, num_bits)
  length = binary.length
  versions = 0
  remaining = length - binary.length
  while remaining < num_bits
    v = process(binary)
    break if v.nil?

    versions += v
  end
  return versions
end

def parse_packets_by_num_packs(binary, num_packs)
  packs = 0
  versions = 0
  while packs < num_packs
    v = process(binary)
    break if v.nil?

    versions += v
    packs += 1
  end
  return versions
end

def parse_literal(binary)
  literal = ""
  loop do
    next_segment = pull_digits(binary, 5)
    literal += next_segment[1, 4]
    break if next_segment[0] == '0' || binary.length < 5
  end
  puts literal.to_i(2)
  return literal.to_i(2)
end

def process(binary)
  if binary.length < 11 then return nil end

  versions = pull_digits(binary, 3).to_i(2)
  type_id = pull_digits(binary, 3).to_i(2)

  case type_id
  when 4
    literal_value = parse_literal(binary)
  else
    length_type_id = pull_digits(binary, 1).to_i(2)
    case length_type_id
    when 0
      length = pull_digits(binary, 15).to_i(2)
      versions += parse_packets_by_num_bits(binary, length)
    else
      length = pull_digits(binary, 11).to_i(2)
      versions += parse_packets_by_num_packs(binary, length)
    end
  end
  return versions
end

for line in input do
  binary = ""
  for char in line.chomp.chars do
    next_four = char.hex.to_s(2).rjust(4, "0")
    binary << next_four
  end
  puts process(binary)
  puts ""
  puts ""
end