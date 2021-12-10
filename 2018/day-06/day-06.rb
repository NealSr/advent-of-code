input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)
verbose = ARGV[1] == "v"

def manhattan(pt1, pt2)
  return (pt1[0] - pt2[0]).abs + (pt1[1] - pt2[1]).abs
end


zero = [0,0]
coords = []
max_x = 0
max_y = 0
for line in input do
  x, y = line.split(", ").map(&:to_i)
  coords << [x, y]
  pp coords
  max_x = [max_x, x].max
  max_y = [max_y, y].max
end


