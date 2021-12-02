triangles = File.readlines("input.txt")

valid = 0
for triangle in triangles
  sides_txt = triangle.split(" ")
  sides = [sides_txt[0].to_i, sides_txt[1].to_i, sides_txt[2].to_i]
  if (sides[0] + sides[1] + sides[2] - sides.max - sides.max) > 0 then valid += 1 end
end

puts valid

valid = 0
row = 0

sides0 = [0,0,0]
sides1 = [0,0,0]
sides2 = [0,0,0]

for triangle in triangles
  sides_row_txt = triangle.split(" ")
  if row == 0 then
  	sides0[0] = sides_row_txt[0].to_i
  	sides1[0] = sides_row_txt[1].to_i
  	sides2[0] = sides_row_txt[2].to_i
  	row += 1
  elsif row == 1 then
  	sides0[1] = sides_row_txt[0].to_i
  	sides1[1] = sides_row_txt[1].to_i
  	sides2[1] = sides_row_txt[2].to_i
  	row += 1
  elsif row == 2 then
  	sides0[2] = sides_row_txt[0].to_i
  	sides1[2] = sides_row_txt[1].to_i
  	sides2[2] = sides_row_txt[2].to_i
  	row = 0
  	if (sides0[0] + sides0[1] + sides0[2] - sides0.max - sides0.max) > 0 then valid += 1 end
  	if (sides1[0] + sides1[1] + sides1[2] - sides1.max - sides1.max) > 0 then valid += 1 end
  	if (sides2[0] + sides2[1] + sides2[2] - sides2.max - sides2.max) > 0 then valid += 1 end
  end
end

puts valid