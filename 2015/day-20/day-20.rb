require 'prime'

input = 34_000_000

def divisors(n)
  divs = n.prime_division.flat_map { |(p, c)| Array.new c, p}
  (0..divs.count).to_a.flat_map { |i| divs.combination(i).to_a }.map { |x| x.inject(1, :*)}.uniq
end

def presents(n)
  divisors(n).inject(0, :+) * 10
end

def presents_2(n)
  divisors(n).select{ |d| d*50 >= n }.inject(0, :+) * 11
end

500_000.upto(1_000_000) do |n|
  x = presents_2 n # x = presents_2 n
  if x >= input
    puts n
    break
  end
end