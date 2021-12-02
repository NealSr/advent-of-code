bag_rules = File.readlines("input.txt")

@all_bags = {}
@all_complex_bags = {}

def has_shiny_gold(outer_color)
  if @all_bags.has_key?(outer_color) then
  	if @all_bags[outer_color].include? 'shiny gold' then
  	  return true
  	else
  	  recursive_search = false
      for bag in @all_bags[outer_color]
        if has_shiny_gold(bag) then
  	      recursive_search = true
  	    end
  	  end
  	  return recursive_search
  	end
  end

  return false
end

for rule in bag_rules
  bag_rule = rule.split("bags contain")
  bag_name = bag_rule[0].strip
  bag_contains = bag_rule[1]
  @all_bags[bag_name] = []
  @all_complex_bags[bag_name] = []
  for string in bag_contains.split(",")
    parts = string.split(" ")
    number = parts[0]
    color = parts[1] + " " + parts[2]
    @all_bags[bag_name] << color
    @all_complex_bags[bag_name] << [number, color]
  end
end

total = 0
@all_bags.each { |k, v|
  if (has_shiny_gold(k)) then total += 1 end
}

puts total


def count_bags(outer_color, subtotal, multiple)
  if @all_complex_bags.has_key? outer_color then
    @all_complex_bags[outer_color].each { |bag_num, bag_name|
      subtotal[bag_name] ||= 0
      subtotal[bag_name] += bag_num.to_i * multiple
      count_bags(bag_name, subtotal, bag_num.to_i * multiple)
    }
  end
end

complex_bag_count = {}
count_bags('shiny gold', complex_bag_count, 1)

complex_total = 0
for bag in complex_bag_count
  complex_total += bag[1]
end
puts complex_total
