data = File.readlines("input.txt").sort

guards = Hash.new { |h, k| h[k] = Hash.new(0) }

guard_number = 0
started_sleeping = 0

for line in data
  if line.include?"Guard" then
  	guard_number = line.split(" ")[3].split("#")[1].to_i
  elsif line.include?"falls asleep" then
  	started_sleeping = line.split(" ")[1].split(":")[1].to_i
  elsif line.include?"wakes up" then
    woke_up = line.split(" ")[1].split(":")[1].to_i
    (started_sleeping...woke_up).each { |minute_asleep| guards[guard_number][minute_asleep] += 1  }
    started_sleeping = 0
  end
end

%i(sum max).each { |f|
  id, minutes = guards.max_by { |_, v| v.values.public_send(f) }
  max_minute = minutes.keys.max_by(&minutes)
  puts "#{"#{id} * #{max_minute} = "}#{id * max_minute}"
}