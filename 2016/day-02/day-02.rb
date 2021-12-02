directions = File.readlines("input.txt")

keypad = [[1,2,3],[4,5,6],[7,8,9]]

solution = ""

xpos = 1
ypos = 1

for direction_row in directions
  direction_row.each_char { |dir|  
    if dir.eql? "U" then
      if ypos > 0 then ypos -= 1 end
    elsif dir.eql? "D" then
      if ypos + 1 <= 2 then ypos += 1 end
    elsif dir.eql? "L" then
      if xpos - 1 >= 0 then xpos -= 1 end
    elsif dir.eql? "R" then
      if xpos + 1 <= 2 then xpos += 1 end
    end
  }
  solution += "#{keypad[ypos][xpos]}"
end
puts solution

keypad = ["  1  "," 234 ","56789"," ABC ","  D  "]
solution = ""

xpos = 3
ypos = 3

for direction_row in directions
  direction_row.each_char { |dir|  
    if dir.eql? "U" then
      if ypos - 1 >= 0 and keypad[ypos - 1][xpos] != " " then ypos -= 1 end
    elsif dir.eql? "D" then
      if ypos + 1 <= 4 and keypad[ypos + 1][xpos] != " " then ypos += 1 end
    elsif dir.eql? "L" then
      if xpos - 1 >= 0 and keypad[ypos][xpos - 1] != " " then xpos -= 1 end
    elsif dir.eql? "R" then
      if xpos + 1 <= 4 and keypad[ypos][xpos + 1] != " " then xpos += 1 end
    end
  }
  solution += "#{keypad[ypos][xpos]}"
end
puts solution