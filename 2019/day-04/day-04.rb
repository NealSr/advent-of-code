def has_3_or_more(pass)
  keys = pass.to_s.chars
  if keys.count('1') > 2 then
    return !(keys.count('2') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('2') > 2 then
    return !(keys.count('1') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('3') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('4') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('3') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('5') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('6') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('7') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('7') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('8') == 2 || keys.count('9') == 2)
  elsif keys.count('8') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('9') == 2)
  elsif keys.count('9') > 2 then
    return !(keys.count('1') == 2 || keys.count('2') == 2 || keys.count('3') == 2 || keys.count('4') == 2 || keys.count('5') == 2 || keys.count('6') == 2 || keys.count('7') == 2 || keys.count('8') == 2)
  end
  return false
end

def valid_password(pass)
  keys = pass.to_s.chars
  if keys[1] >= keys[0] && keys[2] >= keys[1] && keys[3] >= keys[2] && keys[4] >= keys[3] && keys[5] >= keys[4] then
    # continue
  else
    return false
  end

  if keys[0] == keys[1] || keys[1] == keys[2] || keys[2] == keys[3] ||
     keys[3] == keys[4] || keys[4] == keys[5] then
    return true
  else
    return false
  end
end

valid1 = []
for p in 138307..654504 do
  if (valid_password(p)) then
    valid1 << p
  end
end
puts valid1.length

valid2 = []
for valid in valid1 do
  valid2 << valid unless has_3_or_more(valid)
end
puts valid2.length