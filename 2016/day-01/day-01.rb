moves = File.readlines('input.txt')[0].split(", ")

positions = {}
positions["0,0"] = 1

current_direction = 'N'
xpos = 0
ypos = 0

for move in moves do
  turn = move[0]
  distance = move[1..move.length].to_i
  if (current_direction == 'N') then
    if turn == 'L' then
    	for i in 1..distance do
          xpos -= 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end
    	current_direction = 'W'
    else
    	for i in 1..distance do
          xpos += 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end 
      	current_direction = 'E'
    end
  elsif (current_direction == 'E') then
    if turn == 'L' then
    	for i in 1..distance do
          ypos += 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end  
        current_direction = 'N'
    else
    	for i in 1..distance do
          ypos -= 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end 
        current_direction = 'S'
    end
  elsif (current_direction == 'S') then
    if turn == 'L' then
    	for i in 1..distance do
          xpos += 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end
        current_direction = 'E'
    else
    	for i in 1..distance do
          xpos -= 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end
        current_direction = 'W'
    end
  else
    if turn == 'L' then
    	for i in 1..distance do
          ypos -= 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end
        current_direction = 'S'
    else
    	for i in 1..distance do
          ypos += 1
          if positions.has_key?"#{xpos},#{ypos}" then
  	        puts "#{xpos},#{ypos}"
          end
          positions["#{xpos},#{ypos}"] = 1
        end
        current_direction = 'N'
    end
  end
end
puts "Ending Result; #{xpos} X and #{ypos} Y"