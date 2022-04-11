input = File.readlines(ARGV[0] == "test" ? "sample.txt" : "input.txt")

start_time = input[0].chomp.to_i
busses = []
for num in input[1].chomp.split(",")
  busses << num.to_i
end

pp busses
for time in start_time..10040980
  found = false
  for bus in busses
    next if bus == 0
    if time % bus == 0 then
      found = true
      puts "Found: #{time} - #{bus}"
      diff = time - start_time
      puts diff * bus
      break if found
    end
  end
  break if found
end

for i in 225850756400000..325850756401039
  success = true
  busses.each_with_index do |bus, rem|
    next if bus == 0
    if (i+rem) % bus == 0 then
      # continue
    else
      success = false
      break
    end
  end
  if success then puts i end
  break if success
end