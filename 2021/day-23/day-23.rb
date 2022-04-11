input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

board = []
for line in input do
  board << line.chomp.chars
end

@energies = {
    "A" => 1,
    "B" => 10,
    "C" => 100,
    "D" => 1000
}

def energy(start_row,start_col, dest_row,dest_col, char)
  return ((dest_col - start_col).abs + (dest_row - start_row).abs) * @energies[char]
end
