data = File.readlines("input.txt")

def has_sum(data, number)
  possible = data.permutation(2)
  possible.each { |k, v|
    if k.to_i + v.to_i == number.to_i then return true end
  }
  return false
end

def has_sum2(data, number)
  for i in 1..700
    for j in (i + 1)..700
      sum = 0
      data[i..j].each { |num|
        sum += num.to_i
      }
      if sum == number then 
      	puts "#{sum}, #{i}, #{j}, #{data[i].to_i}, #{data[j].to_i}, #{number.to_i}"
      	puts data[i..j].minmax
      end
    end
  end
end

result = 0

for i in 25..1000
  if has_sum(data[i-25..i], data[i]) then
    #do nothing
  else
  	puts "#{i}, #{data[i]}"
  	result = data[i].to_i
  	break
  end
end

puts has_sum2(data, result)