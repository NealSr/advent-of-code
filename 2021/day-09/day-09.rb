input = File.readlines('input.txt', chomp: true)

map = []

for row in input do
  map << row.chars.map(&:to_i)
end

height = map.length
width = map[0].length

low_spots = []
risk = 0

queue = []

basins = []

for row in 0..height - 1 do
  for col in 0..width - 1 do
    floor = map[row][col]
    if row == 0 then up = 9 else
      up = map[row - 1][col] || 9
    end
    if row == height - 1 then down = 9 else
      down = map[row + 1][col] || 9
    end
    if col == 0 then left = 9 else
      left = map[row][col - 1] || 9
    end
    if col == width - 1 then right = 9 else
      right = map[row][col + 1] || 9
    end
    
    if floor < up && floor < down && floor < left && floor < right then
      low_spots << [row, col]
      risk += map[row][col] + 1
    end
  end
end
puts risk

basin_map = {}
basin_size = Hash.new(0)
queue = low_spots.map.with_index { |(x, y), i| [x, y, i] }
queue.each do |x, y, basin|
  basin_map[[x, y]] = basin
  basin_size[basin] += 1
end
while not queue.empty?
  x, y, basin = queue.shift
  [[0, -1], [0, 1], [-1, 0], [1, 0]].each do |dx, dy|
    px, py = x + dx, y + dy
    if (px > 0) && (width > px) && (py > 0) && (height > py) && map[px][py] < 9
      current_basin = basin_map[[px, py]]
      if current_basin.nil?
        basin_map[[px, py]] = basin
        basin_size[basin] += 1
        queue << [px, py, basin]
      elsif current_basin != basin
        raise "bad input?"
      end
    end
  end
end

puts basin_size.values.sort.last(3).inject(:*)