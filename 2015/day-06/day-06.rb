steps = File.readlines("input.txt")

lights = Array.new(1000) { |i| Array.new(1000) { |j| false }}
lights2 = Array.new(1000) { |i| Array.new(1000) { |j| 0 }}


for step in steps
  pieces = step.split(" ")
  operation = pieces[1]
  top = pieces[2]
  bottom = pieces[4]

  x1 = top.split(",")[0].to_i
  y1 = top.split(",")[1].to_i
  x2 = bottom.split(",")[0].to_i
  y2 = bottom.split(",")[1].to_i

  for i in x1..x2
  	for j in y1..y2
  	  if operation == "on" then
  	  	lights[i][j] = true
  	  	lights2[i][j] += 1
  	  elsif operation == "off" then
  	  	lights[i][j] = false
  	  	if lights2[i][j] > 0 then
  	  	  lights2[i][j] -= 1
  	  	end
  	  else
  	  	lights[i][j] = !lights[i][j]
  	  	lights2[i][j] += 2
  	  end
  	end
  end
end

total_on = 0

for light_row in lights
  for light in light_row
  	if light then total_on += 1 end
  end
end

puts total_on

total_brightness = 0

for light_row in lights2
  for light in light_row
  	total_brightness += light
  end
end

puts total_brightness