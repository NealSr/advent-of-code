input = File.readlines('input.txt')
ingredients = {}
names = []
for line in input do
  data = line.split
  ingredients[data[0]] = {
      data[1] => data[2].to_i,
      data[3] => data[4].to_i,
      data[5] => data[6].to_i,
      data[7] => data[8].to_i,
      data[9] => data[10].to_i
  }
  names << data[0]
end

maximum = 0
max_healthy = 0

pp ingredients

total_prop = 100
for i in 1..total_prop do
  remaining1 = total_prop - i
  for j in 1..remaining1 do
    remaining2 = remaining1 - j
    for k in 1..remaining2 do
      remaining3 = remaining2 - k
      for l in 1..remaining3 do
        list = [i, j, k, l]
        if list.sum != 100 then next end
        total_capacity, total_durability, total_flavor, total_texture, total_calories = 0,0,0,0,0
        for m in 0..3 do
          total_capacity += list[m]*ingredients[names[m]]["capacity"]
          total_durability += list[m]*ingredients[names[m]]["durability"]
          total_flavor += list[m]*ingredients[names[m]]["flavor"]
          total_texture += list[m]*ingredients[names[m]]["texture"]
          total_calories += list[m]*ingredients[names[m]]["calories"]
        end
        if total_capacity < 0 then total_capacity = 0 end
        if total_durability < 0 then total_durability = 0 end
        if total_flavor < 0 then total_flavor = 0 end
        if total_texture < 0 then total_texture = 0 end
        total_score = total_capacity * total_durability * total_flavor * total_texture
        if total_score == 9968400 && total_calories == 500 then
            puts i, j, k, l
        end
        maximum = [maximum, total_score].max
        if total_calories == 500 then
          max_healthy = [max_healthy, total_score].max
        end
      end
    end
  end
end

puts maximum
puts max_healthy