require 'colorize'

input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)
verbose = ARGV[1] == "v"

@flashes = 0
grid = [Array.new(12, -500)]
for line in input do
  row = [-500]
  row += line.chomp.chars.map(&:to_i)
  row += [-500]
  grid << row
end
grid << Array.new(12, -500)
pp grid if verbose

def pretty(grid)
    pretty = []
    for row in 1..10 do
      pretty << []
      for col in 1..10 do
        num = grid[row][col]
        if num >= 9 then
          pretty[row - 1] << "X".colorize(:yellow)
        elsif num > 5 && num < 9
          pretty[row - 1] << "x".colorize(:light_yellow)
        else
          pretty[row - 1] << "o".colorize(:blue)
        end
      end
    end
    for row in pretty
      puts row.join
    end
    sleep(0.1)
    puts "\e[H\e[2J"
  end

def has_flashed(row, col, flashed)
  return flashed.include?([row,col])
end

def flash(row, col, grid, flashed)
  if (has_flashed(row, col, flashed)) then
    # do nothing
  else
    @flashes += 1
    flashed << [row,col]
    grid[row - 1][col - 1] += 1
    if grid[row - 1][col - 1] >= 10 then
      flash(row - 1, col - 1, grid, flashed)
    end
    grid[row][col - 1] += 1
    if grid[row][col - 1] >= 10 then
      flash(row, col - 1, grid, flashed)
    end
    grid[row + 1][col - 1] += 1
    if grid[row + 1][col - 1] >= 10 then
      flash(row + 1, col - 1, grid, flashed)
    end

    grid[row - 1][col + 1] += 1
    if grid[row - 1][col + 1] >= 10 then
      flash(row - 1, col + 1, grid, flashed)
    end
    grid[row][col + 1] += 1
    if grid[row][col + 1] >= 10 then
      flash(row, col + 1, grid, flashed)
    end
    grid[row + 1][col + 1] += 1
    if grid[row + 1][col + 1] >= 10 then
      flash(row + 1, col + 1, grid, flashed)
    end

    grid[row + 1][col] += 1
    if grid[row + 1][col] >= 10 then
      flash(row + 1, col, grid, flashed)
    end
    grid[row - 1][col] += 1
    if grid[row - 1][col] >= 10 then
      flash(row - 1, col, grid, flashed)
    end
  end
end

100.times do
  pretty grid
  flashed = []
  for row in 1..10 do
    for col in 1..10 do
      grid[row][col] += 1
    end
  end

  for row in 1..10 do
    for col in 1..10 do
      if grid[row][col] >= 10 then
        flash(row, col, grid, flashed)
      end
    end
  end
  
  for row in 1..10 do
    for col in 1..10 do
      if grid[row][col] >= 10 then
        grid[row][col] = 0
      end
    end
  end
end


pretty grid

pp @flashes

for step in 101..999 do
    pretty grid
    flashed = []
    for row in 1..10 do
      for col in 1..10 do
        grid[row][col] += 1
      end
    end
  
    for row in 1..10 do
      for col in 1..10 do
        if grid[row][col] >= 10 then
          flash(row, col, grid, flashed)
        end
      end
    end
    
    done = true
    for row in 1..10 do
      for col in 1..10 do
        if grid[row][col] >= 10 then
          grid[row][col] = 0
        else
          done = false
        end
      end
    end
    if done then
     # puts step
    end
end