path = File.readlines("input.txt")[0].chomp

sxpos = 0
sypos = 0

ssxpos = 0
ssypos = 0
rxpos = 0
rypos = 0

houses = {}
houses["0,0"] = 1
shouses = {}
shouses["0,0"] = 1

# Part 1
for i in 0..path.length do
  j = i + 1
  move = path[i]
  if move.eql?"^" then
  	sypos += 1
  	if j.even? then
  	  rypos += 1
  	else
  	  ssypos += 1
  	end
  elsif move.eql?">" then
  	sxpos += 1
  	if j.even? then
  	  rxpos += 1
  	else
  	  ssxpos += 1
  	end
  elsif move.eql?"v" then
  	sypos -= 1
  	if j.even? then
  	  rypos -= 1
  	else
  	  ssypos -= 1
  	end
  elsif move.eql?"<" then
  	sxpos -= 1
  	if j.even? then 
  	  rxpos -= 1
  	else
  	  ssxpos -= 1
  	end
  end
  houses["#{sxpos},#{sypos}"] = 1
  shouses["#{rxpos},#{rypos}"] = 1
  shouses["#{ssxpos},#{ssypos}"] = 1
end

puts houses.length
puts shouses.length