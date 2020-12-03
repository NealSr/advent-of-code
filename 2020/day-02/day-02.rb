passwords = File.readlines('input.txt')

total_valid_1 = 0
total_valid_2 = 0

for password in passwords do
  rules = password.split(" ")
  min_max = rules[0]
  min = min_max.split("-")[0].to_i
  max = min_max.split("-")[1].to_i
  character = rules[1]
  word = rules[2]
  # First Problem
  count = word.count(character)
  if (count >= min && count <= max) then
    total_valid_1 = total_valid_1 + 1
  end
  # Second Problem

  first = min - 1
  last = max - 1
  first_match = word[first].eql? character[0]
  last_match = word[last].eql? character[0]
  if (first_match && !last_match) || (last_match && !first_match) then
    total_valid_2 = total_valid_2 + 1
  end
end

puts "Total valid part 1: #{total_valid_1}"
puts "Total valid part 2: #{total_valid_2}"