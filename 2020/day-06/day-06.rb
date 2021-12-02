groups = File.readlines("input.txt")[0].split('|')

total = []
total2 = []
for group in groups
  questions = []
  people = group.split(',')
  num_people = people.length
  questions2 = {}
  for person in people
    person.each_char { |question|  
      questions << question
      if questions2.has_key? question then
      	questions2[question] += 1
      else
      	questions2[question] = 1
      end
    }
  end
  total << questions.uniq.size
  num_total = 0
  questions2.each_value { |count|
    if count == num_people then num_total += 1 end
  }
  total2 << num_total
end

puts total.sum
puts total2.sum