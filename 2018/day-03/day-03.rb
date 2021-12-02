slices = File.readlines("input.txt")
counts = Array.new(1000) { Array.new(1000, 0) }
for slice in slices
  data = slice.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).to_a
  user = data[1]
  left = data[2].to_i + 1
  top = data[3].to_i + 1
  width = data[4].to_i
  height = data[5].to_i
  (top..top + height - 1).each do |row|
  	(left..left + width - 1).each do |col|
  	  counts[row][col] += 1
  	end
  end
end
puts counts.flatten.count { |hits| hits >= 2 }

counts = Array.new(1000) { Array.new(1000) }
maps = []

for slice in slices
  data = slice.match(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).to_a
  user = data[1]
  left = data[2].to_i + 1
  top = data[3].to_i + 1
  width = data[4].to_i
  height = data[5].to_i
  maps << [user, left, top, width, height]
    (top..top + height - 1).each do |row|
  	(left..left + width - 1).each do |col|
  	  counts[row][col] = [] unless counts[row][col]
  	  counts[row][col] << user
  	end
  end
end

puts maps.find { |user, _, _, width, height| counts.flatten(1).count { |a| a == [user] } == width * height }[0]