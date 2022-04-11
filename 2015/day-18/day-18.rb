input = File.readlines(ARGV[0])

lights = []

lights << Array.new(input[0].length + 1, ".")
for line in input do
  lightrow = "."
  lightrow << line.chomp
  lightrow << "."
  lights << lightrow.chars
end
lights << Array.new(input[0].length + 1, ".")

@neighbors = [[-1,-1], [-1,0], [-1,1],
             [0,-1],         [0,1],
             [1,-1], [1,0], [1,1]]

def blink(lights)
  result = []
  for row in 0..lights.length - 1
    if row == 0 || row == lights.length - 1 then
      result << Array.new(lights[0].length, ".")
      next
    end
    result[row] = []
    for col in 0..lights[0].length - 1
      if col == 0 || col == lights[0].length - 1 then
        result[row][col] = "."
        next
      end
      if lights[row][col] == "#" then
        neighbors_on = 0
        for neighbor in @neighbors do
          neighbors_on += 1 if lights[row+neighbor[0]][col+neighbor[1]] == "#"
        end
        if neighbors_on == 2 || neighbors_on == 3 then
          result[row][col] = "#"
        else
          result[row][col] = "."
        end
      else
        neighbors_on = 0
        for neighbor in @neighbors do
          neighbors_on += 1 if lights[row+neighbor[0]][col+neighbor[1]] == "#"
        end
        if neighbors_on == 3 then
          result[row][col] = "#"
        else
          result[row][col] = "."
        end
      end
    end
  end
  result[1][1] = "#"
  result[1][lights.length-2] = "#"
  result[lights.length-2][1] = "#"
  result[lights.length-2][lights.length-2] = "#"
  return result
end

def blinken(lights)
  for row in lights do puts row.join end
end

lights[1][1] = "#"
lights[1][lights.length-2] = "#"
lights[lights.length-2][1] = "#"
lights[lights.length-2][lights.length-2] = "#"

10000.times do
  lights = blink(lights)
  blinken(lights)
  puts
end

total_on = 0
for row in lights do
  for col in row do
    if col == "#" then total_on += 1 end
  end
end
puts total_on