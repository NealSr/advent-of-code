input = File.readlines("input.txt").map(&:chomp)

code_chars = 0
real_chars = 0
esc_chars = 0

for line in input
  code_chars += line.length
  real_chars += eval(line).length
  esc_chars += line.dump.length
end
puts code_chars - real_chars
puts esc_chars - code_chars