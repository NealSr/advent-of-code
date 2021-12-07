def calc_moves(crabs, align)
  moves = 0
  for crab in crabs
    moves += (crab - align).abs
  end
  return moves
end

def calc_fuel(crabs, align)
  fuel = 0
  for crab in crabs
    moves = (crab - align).abs
    fuel += (0..moves).sum
  end
  return fuel
end

input = File.readlines('input.txt')[0].split(',').map(&:to_i)

options = []
options2 = []
for i in input.min..input.max do
  options << calc_moves(input, i)
  options2 << calc_fuel(input, i)
end

puts options.min
puts options2.min