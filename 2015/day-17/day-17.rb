containers = File.readlines('input.txt').map(&:to_i).sort

valid_combinations = 0

puts (2..containers.length).reduce(0){|sum, i| sum + containers.combination(i).count{|c| c.reduce(:+) == 150}}

puts containers.combination(4).count{|c| c.reduce(:+) == 150}
