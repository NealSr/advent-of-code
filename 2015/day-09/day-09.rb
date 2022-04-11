input = File.readlines('input.txt')

distances = {}

for line in input do
 x, to, y, eq, d = line.split
 d = d.to_i
 distances[[x,y].sort] = d
end

pp distances.keys.flatten.uniq.permutation.map { | paths |
  paths.each_cons(2).reduce(0) { | s, x |
    s + distances[x.sort]
  }
}.sort.rotate(-1).first(2)