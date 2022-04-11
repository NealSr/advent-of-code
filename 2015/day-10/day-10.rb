input = "1113222113"

def look_and_say_fast(s)
  return s.gsub(/(.)\1*/) { |match| "#{match.size}#{match[0]}" }
end

def look_and_say(s)
  result = ""
  for letter, chunk in s.chars.chunk{|c| c} do
    result += "#{chunk.length}#{letter}"
  end
  return result
end

50.times do
  input = look_and_say_fast(input)
end

p input.length