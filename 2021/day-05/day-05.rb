lines = File.readlines('input.txt')
grid = Array.new(999) { Array.new(999, 0) }

diagonals = true

for line in lines do
  points = line.split(' -> ')
  x1 = points[0].split(',')[0].to_i
  y1 = points[0].split(',')[1].to_i
  x2 = points[1].split(',')[0].to_i
  y2 = points[1].split(',')[1].to_i
  if (x1 == x2) then
    if (y1 < y2) then
      for y in y1..y2 do
        grid[x1][y] += 1
      end
    else
      for y in y2..y1 do
        grid[x1][y] += 1  
      end
    end
  elsif (y1 == y2) then
    if (x1 < x2) then
      for x in x1..x2 do
        grid[x][y1] += 1
      end
    else
      for x in x2..x1 do
        grid[x][y1] += 1
      end
    end
  elsif diagonals then
    if (x1 > x2) then
      dx = -1
    else
      dx = +1
    end
    if (y1 > y2) then
      dy = -1
    else
      dy = +1
    end

    x = x1
    y = y1
    while ((x != x2) && (y != y2)) do
      grid[x][y] += 1
      x += dx
      y += dy
    end
    grid[x][y] += 1
  end
end

for x in 0..998 do
  for y in 0..998 do
    if (grid[x][y] >= 2) then
      puts x,y,true
    end
  end
end