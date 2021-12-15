input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

grid = []

grid_size = input.length
for row in input do
  grid << row.chomp.chars.map(&:to_i)
end

new_size = grid_size * 5

grid2 = Array.new(new_size) { Array.new(new_size)}

for row in 0..new_size - 1
  for col in 0..new_size - 1
    # new value     =   the corresponding original value       +   the 'step' we're on minus 1 to wrap-around at 9 + 1
    grid2[row][col] = ((grid[row % grid_size][col % grid_size] + (col / grid_size) + (row / grid_size) - 1) % 9) + 1
  end
end

for row in grid2
  puts row.join
end