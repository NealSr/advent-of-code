packages = File.readlines("input.txt")

has_two = 0
has_three = 0

for package in packages
  counts = package.each_char.group_by(&:itself).values.map(&:size)
  if counts.include?(2) then has_two += 1 end
  if counts.include?(3) then has_three += 1 end
end

puts has_two * has_three

require 'set'

seen = Set.new

packages.each { |s|
  s.size.times { |i|
    pair = [s[0...i], s[(i + 1)..-1]]
    puts pair.join if seen.include?(pair)
    seen << pair
  }
}