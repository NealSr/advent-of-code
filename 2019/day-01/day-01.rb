items = File.readlines("input.txt")

total_fuel_required = 0

def get_mass_recursive(starting_mass)
  total = (starting_mass / 3) - 2

  if total > 0 && get_mass_recursive(total) > 0 then
  	total += get_mass_recursive(total)
  end

  return total
end

for item in items do
  fuel_required = get_mass_recursive(item.to_i)
  total_fuel_required += fuel_required
end

puts total_fuel_required