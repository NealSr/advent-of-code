input = File.readlines('input.txt')
part_2 = ARGV[0] == "2"

happinesses = {}
people = []

for line in input do
  a, would, mood, amount, happiness, units, by, sitting, nexts, to, b = line.split('.')[0].split
  h = (mood == "gain") ? amount.to_i : amount.to_i * -1
  happinesses[[a,b]] = h
  happinesses[[a,"Myself"]] = 0 if part_2
  happinesses[["Myself",a]] = 0 if part_2
  people << a unless people.include? a
end
people << "Myself" if part_2

max_h = -999999999999999999999

pp happinesses

people.permutation.each { |p|
  perm_happiness = 0
  for i in 0..p.length-1 do
    if i < p.length-1 then
      pair = [p[i], p[i+1]]
      rev_pair = [p[i+1], p[i]]
    else
      pair = [p[i], p[0]]
      rev_pair = [p[0], p[i]]
    end
    perm_happiness += happinesses[pair]
    perm_happiness += happinesses[rev_pair]
  end
  max_h = [max_h, perm_happiness].max
}

puts max_h