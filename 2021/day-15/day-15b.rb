require 'rgl/adjacency'
require 'rgl/dijkstra'

input = File.readlines(if ARGV[0] == "test" then "sample.txt" elsif ARGV[0] == "2" then "part2.txt" else "input.txt" end)

graph = RGL::DirectedAdjacencyGraph.new

grid = []

edge_weights = {}

grid_size = input.length
width = grid_size - 1
height = grid_size - 1

for row in input do
  grid << row.chomp.chars.map(&:to_i)
end


for row in 0..height do
  for col in 0..width do
    center = "#{row},#{col}"
    up = "#{row-1},#{col}"
    right = "#{row},#{col+1}"
    down = "#{row+1},#{col}"
    left = "#{row},#{col-1}"
    graph.add_vertex(center)
    graph.add_edge(center, up) unless row == 0
    edge_weights[[center,up]] = grid[row-1][col] unless row == 0
    graph.add_edge(up, center) unless row == 0
    edge_weights[[up, center]] = grid[row][col] unless row == 0
    graph.add_edge(center, right) unless col == width
    edge_weights[[center, right]] = grid[row][col+1] unless col == width
    graph.add_edge(right, center) unless col == width
    edge_weights[[right, center]] = grid[row][col] unless col == width
    graph.add_edge(center, down) unless row == height
    edge_weights[[center, down]] = grid[row+1][col] unless row == height
    graph.add_edge(down, center) unless row == height
    edge_weights[[down, center]] = grid[row][col] unless row == height
    graph.add_edge(center, left) unless col == 0
    edge_weights[[center, left]] = grid[row][col-1] unless col == 0
    graph.add_edge(left, center) unless col == 0
    edge_weights[[left, center]] = grid[row][col] unless col == 0
  end
end

solution = graph.dijkstra_shortest_path(edge_weights, "0,0", "#{width},#{height}")

def get_value(grid, point)
  row_col = point.split(",").map(&:to_i)
  return grid[row_col[0]][row_col[1]]
end

risk = 0
for step in solution do
  risk += get_value(grid, step)
end
puts risk - get_value(grid, "0,0")