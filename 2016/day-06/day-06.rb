input = File.readlines('input.txt')

message = []
for line in input do
  message << line.chomp.chars
end

corrected_max = ""
corrected_min = ""
for col in 0..message[0].length - 1 do
  letters = {}
  for row in 0..message.length - 1 do
    if letters.include? message[row][col] then
      letters[message[row][col]] += 1
    else
      letters[message[row][col]] = 1
    end
  end
  max = letters.values.max
  min = letters.values.min
  for letter, num in letters
    if num == max then corrected_max << letter end
    if num == min then corrected_min << letter end
  end
end
puts corrected_max
puts corrected_min