input = File.readlines('input.txt')

algorithm = input[0].chomp.chars

image = input[2..input.length-1].map(&:chomp).map(&:chars)

def count_leds(image)
  count = 0
  for row in image
    for char in row
      if char == "#" then count += 1 end
    end
  end
  return count
end

def get_binary(image, row, col)
  a = image[row-1][col-1] == "#" ? 1 : 0
  b = image[row-1][col] == "#" ? 1 : 0
  c = image[row-1][col+1] == "#" ? 1 : 0
  d = image[row][col-1] == "#" ? 1 : 0
  e = image[row][col] == "#" ? 1 : 0
  f = image[row][col+1] == "#" ? 1 : 0
  g = image[row+1][col-1] == "#" ? 1 : 0
  h = image[row+1][col] == "#" ? 1 : 0
  i = image[row+1][col+1] == "#" ? 1 : 0
  return "#{a}#{b}#{c}#{d}#{e}#{f}#{g}#{h}#{i}".to_i(2)
end

def pad_image(image)
  new_image = []
  width = image[0].length
  top_bottom = Array.new(width+2, ".")
  new_image << top_bottom
  new_image << top_bottom
  for row in image do
    new_row = []
    new_row << "." << "."
    for char in row do
      new_row << char
    end
    new_row << "." << "."
    new_image << new_row
  end
  new_image << top_bottom
  new_image << top_bottom
  return new_image
end

def apply_algorithm(image, algorithm)
  new_image = []
  width = image[0].length
  safe_image = pad_image(image)
  for row in 1..image.length+2
    new_row = ""
    for col in 1..width+2
      new_row << algorithm[get_binary(safe_image, row, col)]
    end
    new_image << new_row.chars
  end
  new_image << Array.new(width+4, ".")
  new_image << Array.new(width+4, ".")
  return new_image
end
pp count_leds(image)

for i in 1..50 do
  image = apply_algorithm(image, algorithm)
  puts "Step #{i}: #{count_leds(image)}"
end