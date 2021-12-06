numbers = File.readlines('input.txt')

grid = []

for number in numbers do
  digits = number.split('')
  grid << digits
end

result = ""
for col in 0..grid[0].length - 1
  sum = 0
  for row in 0..grid.length - 1 do
    sum += grid[row][col].to_i
  end
  result << (if (sum > 500) then "1" else "0" end)
end

puts result