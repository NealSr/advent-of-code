rows = File.readlines("input.txt").each.map { |l| l.split.map(&method(:Integer)) }

result = 0
rows.each { |row|  
  result += row.minmax.reduce(:-)
}
puts -result

result = 0
rows.each { |row|
  result += row.permutation(2).find { |a, b| a % b == 0 }.reduce(:/)
}
puts result