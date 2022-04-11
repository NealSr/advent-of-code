input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

grid = []
for line in input do
  grid << line.chomp.chars
end

def move_right(start)
  moves = 0
  result = []
  for row in 0..start.length-1
    result[row] = []
    for col in 0..start[row].length-1
      if start[row][col] == ">" then
        if col < start[row].length-1 then
          if start[row][col+1] == "." then
            result[row][col] = "."
            result[row][col+1] = ">"
            moves += 1
          else
            result[row][col] = start[row][col]
          end
        else
          if start[row][0] == "." then
            result[row][col] = "."
            result[row][0] = ">"
            moves += 1
          else
            result[row][col] = start[row][col]
          end
        end
      end
      result[row][col] ||= start[row][col]
    end
  end
  return [moves, result]
end

def move_down(start)
  moves = 0
  result = []
  for row in 0..start.length-1
    if result[row] == nil then result[row] = [] end
    for col in 0..start[row].length-1
      if start[row][col] == "v" then
        if row < start.length-1 then
          if start[row+1][col] == "." then
            result[row][col] = "."
            if result[row+1] == nil then result[row+1] = [] end
            result[row+1][col] = "v"
            moves += 1
          else
            result[row][col] = start[row][col]
          end
        else
          if start[0][col] == "." then
            result[row][col] = "."
            result[0][col] = "v"
            moves += 1
          else
            result[row][col] = start[row][col]
          end
        end
      end
      result[row][col] ||= start[row][col]
    end
  end
  return [moves, result]
end

def pgrid(grid)
  for row in grid do
    puts row.join
  end
  puts
end

for i in 1..1000 do
  right, grid = move_right(grid)
  down, grid = move_down(grid)
  if right + down == 0 then
    puts i
    break
  end
  puts "\e[H\e[2J"
  pgrid grid
  sleep(0.1)
end
