input = File.readlines('input.txt')

def parse(fishstring)
  depth = 0
  result = []
  fishstring.chars.each do |char|
    if char.match?(/\d/)
      result << char.to_i + depth.i
    elsif char == "["
      depth += 1
    elsif char == "]"
      depth -= 1
    end
  end
  return result
end

def explode(fisharray, index)
  first, second = fisharray.slice(index, 2)
  fisharray[index - 1] += first.real if index != 0
  fisharray[index + 2] += second.real if fisharray[index + 2]
  fisharray.delete_at(index)
  fisharray[index] = 0 + (first.imaginary - 1).i
end

def split(fisharray, index)
  fisharray.insert(index + 1, (fisharray[index].real / 2.0).round + (fisharray[index].imaginary + 1).i)
  fisharray[index] = fisharray[index].real / 2 + (fisharray[index].imaginary + 1).i
end

def get_magnitude(fisharray)
  loop do
    max_depth = fisharray.map(&:imaginary).max
    break if max_depth == 0
    index = fisharray.index{ _1.imaginary == max_depth }
    fisharray[index] = 3 * fisharray[index].real + 2 * fisharray[index + 1].real + (fisharray[index].imaginary - 1).i
    fisharray.delete_at(index + 1)
  end
  return fisharray.first.real
end

def add_snails(snail_a, snail_b)
  joined = snail_a.dup.concat(snail_b).map{_1 + 1.i}
  loop do
    index_to_explode = joined.index{_1.imaginary >= 5}
    if index_to_explode
      explode(joined, index_to_explode) and next
    end
    index_to_split = joined.index{_1.real >= 10}
    if index_to_split
      split(joined, index_to_split) and next
    end
    break
  end
  return joined
end

fish = []
for number in input do
  fish << parse(number.chomp)
end
reduced = fish.reduce{add_snails(_1, _2)}
pp reduced
pp get_magnitude(reduced)
pp fish.permutation(2).map{ |a, b| get_magnitude(add_snails(a, b))}.max
