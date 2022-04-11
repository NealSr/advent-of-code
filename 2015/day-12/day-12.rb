require 'json'

input = File.readlines('input.json')[0].chomp

j = JSON.parse(input)

$part_2 = 0

def count(j)
  return if j.is_a? Hash and j.values.include?("red")
  
  if j.is_a? Array then
    j.each { |y| count(y) } if j.class.method_defined? :each
  else
    j.values.each { |y| count(y) } if j.class.method_defined? :each
  end
  $part_2 += j if j.is_a? Integer
end

count(j)
pp $part_2