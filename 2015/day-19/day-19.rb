require 'set'

input = File.read(ARGV[0])

sub_input = input.split("\n\n")[0]
start = input.split("\n\n")[1]

subs = sub_input.split("\n")
substitutions = []
possibilities = Set[]
for sub in subs do
  key, value = sub.chomp.split(" => ")
  substitutions << [key, value]
end

def replace(s, sub, value, i)
  if i == 0 then
    return "#{value}#{s[sub.length..]}"
  else
    return "#{s[0..i-1]}#{value}#{s[i+sub.length..]}"
  end
end

for sub, value in substitutions
  for i in 0..start.length do
    if start[i..i+sub.length-1] == sub then
      new_string = replace(start, sub, value, i)
      possibilities << new_string
    end
  end
end

pp possibilities.length

steps = 0
while(start != "e") do
  for sub, value in substitutions do
    if (start.include?(value)) then
      start = replace(start, value, sub, start.index(value))
      steps += 1
    end
  end
end
puts steps