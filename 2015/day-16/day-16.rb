MX = 100
$map = {
    'children' => 3..3,
    'cats' => (7+1)..MX,
    'samoyeds' => 2..2,
    'pomeranians' => 0..(3-1),
    'akitas' => 0..0,
    'vizslas' => 0..0,
    'goldfish' => 0..(5-1),
    'trees' => (3+1)..MX,
    'cars' => 2..2,
    'perfumes' => 1..1,
}

p $stdin.readlines.select { |line|
    !line.split()[2..-1].each_slice(2).any? { |k, v| !$map[k[0..-2]].include?(v.to_i) }
}