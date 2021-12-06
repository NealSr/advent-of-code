input = File.readlines('input.txt')[0].split(',').map(&:to_i)

fishes = {}
for fish_age in input do
  if fishes[fish_age].nil? then
    fishes[fish_age] = 1
  else
    fishes[fish_age] += 1
  end
end

def pass_day(fishes)
  new_fish = fishes[0] || 0
  for age in 0..7 do
    fishes[age] = fishes[age + 1] || 0
  end
  fishes[6] += new_fish
  fishes[8] = new_fish || 0
  puts fishes
end

for day in 1..256 do
  puts "Day #{day}:  "
  pass_day(fishes)
end

total_fish = 0
for age, total in fishes do
  total_fish += total
end
puts total_fish