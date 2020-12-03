moves = File.readlines('tmp.txt')

positions = {}

position = 0

for move in moves do
  action = move.to_i
  position = position + action
  if positions.has_key?(position) then
  	positions[position] = positions[position] + 1
    puts "FOUND ONE: #{position}"
    break
  end
  positions[position] = 1
end