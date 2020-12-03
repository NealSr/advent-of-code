captcha = File.readlines('input.txt')[0]

sum = 0

for i in 0..captcha.length do
  right_pointer = i + 1060
  if right_pointer > captcha.length-1 then
  	right_pointer -= 2120
  end
  if captcha[i].eql?captcha[right_pointer] then
  	sum += captcha[i].to_i
  end
end
puts sum