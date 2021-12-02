passwords = File.readlines("input.txt")

valid = 0
for password in passwords
  if password.split(" ").uniq == password.split(" ") then valid += 1 end
end
puts valid

double_valid = 0
for password in passwords
  sorted = password.split(" ").map { |w| w.chars.sort  }
  if sorted.uniq == sorted then double_valid += 1 end
end
puts double_valid