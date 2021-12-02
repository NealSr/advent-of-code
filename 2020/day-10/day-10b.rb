require 'set'

values = File.read('input.txt').lines(chomp: true).map(&:to_i)
adapters = Set.new(values)

$memoize = {}
def resolve(at, adapters, max)
  return 1 if at == max
  if !$memoize.has_key?(at)
    possible = []
    possible.push(resolve(at+1, adapters, max)) if adapters.include?(at+1)
    possible.push(resolve(at+2, adapters, max)) if adapters.include?(at+2)
    possible.push(resolve(at+3, adapters, max)) if adapters.include?(at+3)
    $memoize[at] = possible.sum
  end
  return $memoize[at]
end

puts resolve(0, adapters, values.max)
