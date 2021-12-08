input = File.readlines('input.txt')

number_segments = [6,2,5,5,4,5,6,3,7,6]

total_easy = 0
for row in input do
  four = row.split('|')[1].split(' ')
  for digit in four do
    if digit.length == number_segments[1] || digit.length == number_segments[4] || digit.length == number_segments[7] || digit.length == number_segments[8] then
      total_easy += 1
    end
  end
end
puts total_easy

def get_match(all, size)
  for sign in all do
    if sign.length == size then
      return sign.chars.sort.join
    end
  end
end

def get_three(two_three_five, seven)
  for number in two_three_five do
    if number.include?(seven[0]) && number.include?(seven[1]) && number.include?(seven[2]) then
      return number
    end
  end
end

def get_six(zero_six_nine, one)
  for number in zero_six_nine do
    if (number.include?(one[0]) && !number.include?(one[1])) || (number.include?(one[1]) && !number.include?(one[0])) then
      return number
    end
  end
end

def get_nine(zero_six_nine, four)
  for number in zero_six_nine do
    if number.include?(four[0]) && number.include?(four[1]) && number.include?(four[2]) && number.include?(four[3]) then
      return number
    end
  end
end

def get_zero(zero_six_nine, six, nine)
  for number in zero_six_nine do
    if number != six && number != nine then
      return number
    end
  end
end

def get_two(two_three_five, three, seven, nine)
  for number in two_three_five do
    if number != three then
      for seg in number.chars do
        if !nine.include?(seg) then
          return number
        end
      end
    end
  end
end

def get_five(two_three_five, two, three)
    for number in two_three_five do
      if number != two && number != three then
        return number
      end
    end
  end

def get_value(string, key)
  key.each { |val, str|
    if string == str then return val.to_s end
  }
end

total = 0
for row in input do
  all = row.split('|')[0].split(' ')

  key = {}
  key[1] = get_match(all,number_segments[1])
  key[4] = get_match(all,number_segments[4])
  key[7] = get_match(all,number_segments[7])
  key[8] = get_match(all,number_segments[8])

  two_three_five = []
  zero_six_nine = []
  for sign in all do
    if sign.length == 5 then
      two_three_five << sign.chars.sort.join
    elsif sign.length == 6 then
      zero_six_nine << sign.chars.sort.join
    end
  end
  key[6] = get_six(zero_six_nine, key[1])
  key[9] = get_nine(zero_six_nine, key[4])
  key[0] = get_zero(zero_six_nine, key[6], key[9])


  key[3] = get_three(two_three_five, key[7])
  key[2] = get_two(two_three_five, key[3], key[7], key[9])
  key[5] = get_five(two_three_five, key[2], key[3])

  puts key

  last = row.split('|')[1].split(' ')
  number = ""
  number << get_value(last[0].chars.sort.join, key)
  number << get_value(last[1].chars.sort.join, key)
  number << get_value(last[2].chars.sort.join, key)
  number << get_value(last[3].chars.sort.join, key)
  puts number
  total += number.to_i
end
puts total