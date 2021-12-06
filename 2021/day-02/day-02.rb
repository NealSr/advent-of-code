numbers = File.readlines('input.txt')

distance = 0
depth = 0
aim = 0

for line in numbers do
  command = line.split(' ')
  case command[0]
  when 'forward'
    distance += command[1].to_i
    depth += (aim * command[1].to_i)
  when 'up'
    aim -= command[1].to_i
  when 'down'
    aim += command[1].to_i
  end
end

puts "distance: #{distance} depth: #{depth}"