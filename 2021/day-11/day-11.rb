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


pp grid

pp @flashes

for step in 101..999 do
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
      puts step
      break
    end
end