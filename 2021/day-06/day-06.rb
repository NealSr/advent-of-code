class Lanternfish
  def initialize(age)
    @age = age
  end

  def grow?
    @age -= 1
    if @age == -1 then
      @age = 6
      return true
    else
      return false
    end
  end

  def to_s
    "#{@age}"  
  end
end

def pass_day(fishes)
  new_fish = fishes[0] || 0
  fishes[0] = fishes[1] || 0
  fishes[1] = fishes[2] || 0
  fishes[2] = fishes[3] || 0
  fishes[3] = fishes[4] || 0
  fishes[4] = fishes[5] || 0
  fishes[5] = fishes[6] || 0
  fishes[6] = fishes[7] || 0
  fishes[6] += new_fish
  fishes[7] = fishes[8] || 0
  fishes[8] = new_fish || 0
  puts fishes
end


input = File.readlines('input.txt')[0].split(',').map(&:to_i)

fishes = {}
for fish_age in input do
  if fishes[fish_age].nil? then
    fishes[fish_age] = 1
  else
    fishes[fish_age] += 1
  end
end

puts fishes

for day in 1.. do
  if day > 256 then break end
  puts "Day #{day}:  "
  pass_day(fishes)
end

total_fish = 0
for age, total in fishes do
  total_fish += total
end
puts total_fish