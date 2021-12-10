verbose = ARGV[0] == 'v'
input = File.readlines('input.txt')[0].chars

working = input.clone
to_delete = []

needs_work = true
while needs_work do
  needs_work = false
  for i in 0..working.length - 2
    if (working[i].ord - working[i+1].ord).abs == 32 then
      needs_work = true
      to_delete << i
      to_delete << i+1
      break
    end
  end
  offset = 0
  puts working.join if verbose
  for index in to_delete do
    working.delete_at(index - offset)
    offset += 1
  end
  to_delete = []
  offset = 0
end
puts working.length

improved = []
for i in 65..90 do
  new_working = input.clone
  puts new_working.join if verbose
  lower = (i + 32).chr
  upper = i.chr
  new_working.delete(lower)
  new_working.delete(upper)
  puts new_working.join if verbose
  needs_work = true
  while needs_work do
    needs_work = false
    for i in 0..new_working.length - 2
      if (new_working[i].ord - new_working[i+1].ord).abs == 32 then
        needs_work = true
        to_delete << i
        to_delete << i+1
        break
      end
    end
    offset = 0
    puts working.join if verbose
    for index in to_delete do
      new_working.delete_at(index - offset)
      offset += 1
    end
    to_delete = []
    offset = 0
  end
  puts new_working.length if verbose
  improved << new_working.length
end
puts improved.min