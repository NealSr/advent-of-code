commands = File.readlines(ARGV[0] == 'test' ? 'sample.txt' : 'input.txt').map(&:to_i)

position = 0

steps = 0
while (position >= 0 && position <= commands.length - 1) do
  action = commands[position]
  if action >= 3 then
    commands[position] -= 1
  else
    commands[position] += 1
  end
  position += action
  steps += 1
end

puts "Pos: #{position}, Steps: #{steps}"