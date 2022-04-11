input = File.read(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

#target area: x=20..30, y=-10..-5
targetx = input.split(" ")[2][2..-2].split("..").map(&:to_i)
targety = input.split(" ")[3][2..].split("..").map(&:to_i)

probe_x, probe_y = 0,0

def in_range(probe_x, probe_y, targetx, targety)
  return (targetx[0]..targetx[1]).include?(probe_x) && (targety[0]..targety[1]).include?(probe_y)
end


def simulate(dx, dy, targetx, targety)
  hit, probe_x, probe_y, max_y = false,0,0,0
  loop do
    probe_x += dx
    probe_y += dy
    if dx > 0 then
      dx -= 1
    elsif dx < 0 then
      dx += 1
    end
    dy -= 1
    max_y = [max_y, probe_y].max
    if in_range(probe_x, probe_y, targetx, targety) then
      hit = true
      break
    end
    break if probe_y < targety.min
  end
  return [hit, probe_x, probe_y, max_y]
end

#target area: x=150..193, y=-136..-86
successes = []
num_successes = 0
for dx in -1000..1000 do
  for dy in -1000..1000 do
    result = simulate(dx, dy, targetx, targety)
    if result[0] then
      successes << result
      num_successes += 1
    end
  end
end

max_y = 0
for success in successes do
  max_y = [max_y, success[3]].max
end
puts max_y
puts successes.length
puts num_successes



all_possibilities = (-100..300).to_a.product((-100..400).to_a).map { |dx, dy| simulate(dx, dy, targetx, targety) }.filter { _1[0] }
p all_possibilities.map { _1.last }.max
p all_possibilities.count