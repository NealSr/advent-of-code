numbers = File.readlines('input.txt')

for num1 in 1..numbers.length - 1 do
    window_sum = numbers[num1 - 1].to_i + numbers[num1].to_i + numbers[num1 + 1].to_i
    puts window_sum
end