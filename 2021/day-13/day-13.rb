require 'set'

input = File.read(if ARGV[0] == "test" then "sample.txt" else "input.txt" end).split("\n\n")

coords = input[0].split("\n")

def print_grid(points)
  grid2 = []
  width2 = 0
  height2 = 0
  for point in points do
    x = point[0]
    y = point[1]
    width2 = [width2, x].max
    height2 = [height2, y].max
  end
  
  for row in 0..height2
    grid2[row] = []
    for col in 0..width2 do
      grid2[row][col] = "."
    end
  end
  
  for point in points do
    col = point[0]
    row = point[1]
    grid2[row][col] = "#"
  end

  for row in grid2
    puts row.join()
  end

  return grid2
end

def fold_up(grid, y, points)
  new_points = []
  for point in points do
    px = point[0]
    py = point[1]
    if (py > y) then
      new_y = 2*y - py
      points.delete([px, py])
      new_points << ([px, new_y])
    end
  end
  points.merge(new_points)
end

def fold_left(grid, x, points)
  new_points = []
  for point in points do
    px = point[0]
    py = point[1]
    if (px > x) then
      new_x = 2*x - px
      points.delete([px, py])
      new_points << ([new_x, py])
    end
  end
  points.merge(new_points)
end

width = 0
height = 0

points = Set.new

for point in coords do
  x, y = point.split(',').map(&:to_i)
  width = [width, x].max
  height = [height, y].max
  points << [x,y]
end

grid = print_grid(points)

folds = input[1].split("\n")

for fold in folds do
  # fold along y=7
  dir, line = fold.split(" ")[2].split("=")
  case dir
  when "y"
    fold_up(grid, line.to_i, points)
  when "x"
    fold_left(grid, line.to_i, points)
  end
  sleep(0.1)
  print_grid(points)
end

