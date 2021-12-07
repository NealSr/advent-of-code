input = File.readlines('input.txt')
line1 = input[0].split(',')
line2 = input[1].split(',')

grid = Array.new(19999) { Array.new(19999, 0) }
grid2 = Array.new(19999) { Array.new(19999, 0) }

x = 0
y = 0

line_1_steps = 0
for command in line1 do
  case command[0]
    when 'U'
      dx = 0
      dy = 1    
    when 'D'
      dx = 0
      dy = -1  
    when 'L'
      dx = -1
      dy = 0
    when 'R'
      dx = 1
      dy = 0
    end
    
  command[1..].to_i.times do
    line_1_steps += 1
    x += dx
    y += dy
    grid[x][y] = 1
    if grid2[x][y] == 0 then
      grid2[x][y] = line_1_steps
    end
  end
end

x = 0
y = 0
twos = []
line_2_steps = 0
for command in line2 do
    case command[0]
      when 'U'
        dx = 0
        dy = 1    
      when 'D'
        dx = 0
        dy = -1  
      when 'L'
        dx = -1
        dy = 0
      when 'R'
        dx = 1
        dy = 0
      end
      
    command[1..].to_i.times do
      line_2_steps += 1
      x += dx
      y += dy
      if grid[x][y] == 1 then
        twos << "#{x},#{y},#{grid2[x][y]},#{line_2_steps}"
      end
    end
  end

distances = []
steps = []
for two in twos do
  distance = two.split(',')[0].to_i.abs + two.split(',')[1].to_i.abs
  distances << distance
  step = two.split(',')[2].to_i + two.split(',')[3].to_i
  steps << step
end
puts distances.min
puts steps.min