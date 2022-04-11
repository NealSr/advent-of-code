require 'set'

input = File.read(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

@remaps = [0,1,2].permutation.to_a
@negations = [[1,1,1],[1,1,-1],[1,-1,1],[1,-1,-1],[-1,1,1],[-1,1,-1],[-1,-1,1],[-1,-1,-1]]

grids = {}

for scanner in input.split("\n\n")
  rows = scanner.split("\n")
  scanner_id = rows[0].split(" ")[2].to_i
  grids[scanner_id] = []
  for i in 1..rows.length - 1 do
    grids[scanner_id] << rows[i].split(",").map(&:to_i)
  end
end

def realign(remap, negation, grid)
  result = []
  for coords in grid
    result << [negation[0]*coords[remap[0]], negation[1]*coords[remap[1]], negation[2]*coords[remap[2]]]
  end
  return result
end

@origins = [[0,0,0]]
def array_matches(grid_a, grid_b, min_matches)
  for remap in @remaps do
    for negation in @negations do
      a = grid_a.dup
      b = realign(remap, negation, grid_b)
      for a_pos in a do
        for b_pos in b do
          remap_by = [b_pos[0]-a_pos[0], b_pos[1]-a_pos[1], b_pos[2]-a_pos[2]]
          matches = 0
          all_remapped = []
          for other_b in b do
            remapped_to_a = [other_b[0]-remap_by[0], other_b[1]-remap_by[1], other_b[2]-remap_by[2]]
            if a.include?remapped_to_a then matches += 1 end
            all_remapped << remapped_to_a
          end
          if matches >= min_matches then
            puts "Match: #{remap_by}"
            @origins << remap_by
            return [true, all_remapped]
          end
        end
      end
    end
  end
  return [false, nil]
end

aligned_indices = []
aligned_indices << 0
aligned = {}
aligned[0] = grids[0]
all_aligned = []
for point in grids[0]
  all_aligned << point
end
noalign = []

while aligned_indices.length < grids.length do
  for i in 0..grids.length-1 do
    if aligned_indices.include?(i) then next end
    for j in aligned_indices do
      puts "Checking #{i} against #{j}"
      if noalign.include?([i,j]) then next end
      matches = array_matches(aligned[j], grids[i], 12)
      if matches[0] then
        aligned_indices << i
        aligned[i] = matches[1]
        for match in matches[1]
          all_aligned << match
        end
        break
      end
      noalign << [i,j]
    end
  end
end
puts all_aligned.to_set.length

dists = []
for a in @origins
  for b in @origins
    dists << [(a[0]-b[0]).abs, (a[1]-b[1]).abs, (a[2]-b[2]).abs].sum
  end
end
puts dists.max