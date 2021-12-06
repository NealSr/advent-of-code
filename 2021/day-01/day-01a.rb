numbers = File.readlines('b_input.txt')

for num1 in 1..numbers.length do
    down = numbers[num1].to_i > numbers[num1 - 1].to_i
    puts down
end