numbers = File.readlines('input.txt')

for num1 in 0..numbers.length do
  for num2 in num1 + 1..numbers.length do
    for num3 in num1 + 2..numbers.length do
      sum = numbers[num1].to_i + numbers[num2].to_i + numbers[num3].to_i
      if sum == 2020 then
        puts numbers[num1]
        puts numbers[num2]
        puts numbers[num3]
        puts (numbers[num1].to_i * numbers[num2].to_i * numbers[num3].to_i)
      end
    end
  end
end