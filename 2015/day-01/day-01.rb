moves = File.readlines('input.txt')

position = 0

for move in moves do
  for i in 0..move.length do
  	if move[i].eql?"(" then
  	  position = position + 1
  	end
  	if move[i].eql?")" then
  	  position = position - 1
  	end
  	if position < 0 then
  		puts "Reached -1 at position: #{i + 1}"
  		break;
  	end
  end
  moves_down = move.count(")")
  moves_up = move.count("(")

  puts "Moved up #{moves_up}"
  puts "Moved down #{moves_down}"
  puts "Result: #{moves_up - moves_down}"
end