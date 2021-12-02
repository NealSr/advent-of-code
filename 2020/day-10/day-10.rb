adapters = File.readlines("input.txt").map(&:to_i)

adapters << 0
adapters << adapters.max + 3

adapters = adapters.sort

puts "Part 1 can be solved in Excel"

def can_drop(array, position)
  if position == 0 then return false end

  return (array[position - 1] + 3) >= array[position + 1]

end

factorial = 0
for i in 0..adapters.length - 2
  puts "#{adapters[i]}, #{can_drop(adapters, i)}"
  if (can_drop(adapters, i)) then
    factorial += 1
  end
end

puts factorial

dp = Hash.new{|h,x|
  h[x] = (x-3...x).filter{|i|adapters.include? i}.map{|i|h[i]}.sum
}
dp[0] = 1
puts dp 

puts dp[adapters.max]

puts dp