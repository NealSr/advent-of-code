passports = File.readlines("input.txt")[0].split('|')

puts passports.length

valid = 0

def has_all_field(records)
  has_byr = false
  has_iyr = false
  has_eyr = false
  has_hgt = false
  has_hcl = false
  has_ecl = false
  has_pid = false
  for record in records do
    if record.start_with?"byr" then
      byr = record.split(":")[1].to_i
      has_byr = byr >= 1920 && byr <= 2002
    elsif record.start_with?"iyr" then
      iyr = record.split(":")[1].to_i
      has_iyr = iyr >= 2010 && iyr <= 2020
    elsif record.start_with?"eyr" then
      eyr = record.split(":")[1].to_i
      has_eyr = eyr >= 2020 && eyr <= 2030
    elsif record.start_with?"hgt" then
      hgt = record.split(":")[1]
      if hgt.end_with?"in" then
      	hgtin = hgt.split("i")[0].to_i
      	has_hgt = hgtin >= 59 && hgtin <= 76
      elsif hgt.end_with?"cm" then
      	hgtcm = hgt.split("c")[0].to_i
      	has_hgt = hgtcm >= 150 && hgtcm <= 193
      end
    elsif record.start_with?"hcl" then
      hcl = record.split(":")[1]
      has_hcl = hcl.match(/^#[0-9a-f]{6}$/)
    elsif record.start_with?"ecl" then
      ecl = record.split(":")[1]
      has_ecl = ["amb","blu","brn","gry","grn","hzl","oth"].include?ecl
    elsif record.start_with?"pid" then
      pid = record.split(":")[1]
      has_pid = pid.match(/^[0-9]{9}$/)
    end
  end
  return has_byr && has_iyr && has_eyr && has_hgt && has_hcl && has_ecl && has_pid
end

for passport in passports do
  records = passport.split(" ")
  if has_all_field(records) then valid += 1 end    
end

puts valid