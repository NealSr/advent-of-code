input = File.read(if ARGV[0] == "test" then "sample.txt" else "input.txt" end).split("\n\n")

template = input[0].chomp
codes = input[1].split("\n")

puts template

lookup = {}
lookup2 = {}
for code in codes
  left = code.split(" -> ")[0]
  right = code.split(" -> ")[1]
  lookup[left] = right
  lookup2[left] = ["#{left[0]}#{right}","#{right}#{left[1]}"]
end

def get_new_string(input, table)
  new_string = ""
  for i in 0..input.length - 2
    look = input[i,2]
    if table.include?(look) then
      new_string += table[look]
    else
      new_string += "_"
    end
  end
  return new_string
end

def insert_string(string, to_insert)
  result = string
  for i in 0..to_insert.length - 1
    result = result.insert(2*i+1, to_insert[i])
  end
  return result
end


10.times do
  to_insert = get_new_string(template, lookup)

  result = insert_string(template, to_insert)
  totals = result.each_char.with_object(Hash.new(0)) {|c,m| m[c]+=1}
  max = 0
  min = 9992188189693529
  for value in totals.values do
    max = [max,value].max
    min = [min,value].min
  end
  puts max - min
end

def process_string_2(pairs, lookup_2)
  result = {}
  for pair, quantity in pairs do
    new_pairs = lookup_2[pair]
    result[new_pairs[0]] ||= 0
    result[new_pairs[0]] += quantity
    result[new_pairs[1]] ||= 0
    result[new_pairs[1]] += quantity
  end
  return result
end

start = input[0].chomp

start_pairs = {}

for i in 0..start.length - 2
  pair = start[i,2]
  start_pairs[pair] ||= 0
  start_pairs[pair] += 1    
end

pp start_pairs

pp lookup2

40.times do
  start_pairs = process_string_2(start_pairs, lookup2)
  pp start_pairs

  frequency = {}
  for pair, quantity in start_pairs do
    frequency[pair[0]] ||= 0
    frequency[pair[1]] ||= 0
    frequency[pair[0]] += quantity
    frequency[pair[1]] += quantity
  end

  pp frequency

  min = 9993864643915075439499
  max = 0

  for letter, quantity in frequency do
    max = [max,quantity].max
    min = [min,quantity].min
  end

  puts max, min, max-min/2
end



