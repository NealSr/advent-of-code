input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)
verbose = ARGV[1] == "v"

@valid_parens = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
}

@reverse = {
    ")" => "(",
    "]" => "[",
    "}" => "{",
    ">" => "<"
}

@paren_score = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
}

@auto_score = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
}

@opening_parens = @valid_parens.keys
@closing_parens = @valid_parens.values

def valid_parentheses(string)
  stack  = []
  string.each_char do |ch|
    if @opening_parens.include?(ch)
      stack << ch
    elsif @closing_parens.include?(ch)
      ch == @valid_parens[stack.last] ? stack.pop : (return ch)
    end
  end
  stack.empty?
end

def solve_parens(string)
  while string.include?(@closing_parens[0]) || string.include?(@closing_parens[1]) || string.include?(@closing_parens[2]) || string.include?(@closing_parens[3]) do    
    string = string.gsub("()", "")
    string = string.gsub("{}", "")
    string = string.gsub("[]", "")
    string = string.gsub("<>", "")
  end
  return string
end

final_score = 0
incomplete_lines = []
for line in input do
  if (valid_parentheses(line)) then
    final_score += @paren_score[valid_parentheses(line)]
  else
    incomplete_lines << line.chomp
  end
end
puts final_score

solutions = []
for line in incomplete_lines do
  solution = solve_parens(line).reverse
  solver_score = 0
  solution.each_char do |ch|
    solver_score *= 5
    solver_score += @auto_score[@valid_parens[ch]]
  end
  solutions << solver_score
end

puts solutions.sort[solutions.length / 2]
