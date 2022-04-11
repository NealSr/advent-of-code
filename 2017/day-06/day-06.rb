banks = File.readlines(ARGV[0] == 'test' ? 'sample.txt' : 'input.txt')[0].chomp.split.map(&:to_i)

size = banks.length
cycles = 0
signatures = []
master_sig = nil
loop do
  if signatures.include?(banks) && master_sig.nil? then
    master_sig = banks.dup
    puts "FIRST_MATCH: #{master_sig} - #{cycles}"
  end
  signatures << banks.dup
  cycles += 1
  max_idx = banks.index(banks.max)
  amount = banks[max_idx]
  banks[max_idx] = 0
  i = 0
  while amount > 0 do
    i += 1
    banks[(max_idx + i) % size] += 1
    amount -= 1
  end
  break if master_sig == banks
end

pp cycles