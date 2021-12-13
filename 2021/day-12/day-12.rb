require 'set'
require 'rgl/adjacency'
require 'rgl/dot'
require 'colorize'

input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)
verbose = ARGV[1] == "v"

def read_graph(input)
  graph = RGL::DirectedAdjacencyGraph.new
  for line in input do
    left, right = line.chomp.split('-')
    graph.add_edge left, right
    graph.add_edge right, left
  end
  return graph
end

def color_print(graph, point)
  puts "\e[H\e[2J"
  output = ""
  i = 0
  for entry in graph.keys do
    i += 1
    if point == 'end' || entry == 'end' then
      if point == 'end'
        output << entry.colorize(:red)
        output << " "
        output << "\n" if (i % 3 == 0)
      end
    elsif entry == point then
      output << entry.colorize(:yellow)
      output << " "
      output << "\n" if (i % 3 == 0)
    else
      output << entry.colorize(:blue)
      output << " "
      output << "\n" if (i % 3 == 0)
    end
  end
  puts output
end


def read_input(input)
  paths = Hash.new

  for line in input do
    left, right = line.chomp.split('-')
    if !paths.include?(left) then
      paths[left] = []
    end
    paths[left] << right
    if !paths.include?(right) then
      paths[right] = []
    end
    paths[right] << left
  end
  return paths
end

@total = 0

def count_paths(map, current, visited)
  if current == 'end' then
    @total += 1
  end
  if current.downcase == current then
    visited.add(current)
  end
  for path in map[current] do
    if visited.include?(path) then
       # do nothing
    else
      count_paths(map, path, visited.dup)
    end
  end
end

@total_2 = 0

def count_paths_2(map, current, visited, double)
  color_print(map, current)
  sleep(0.1)
  if current == 'end' then
    @total_2 += 1
    return
  end
  if current.downcase == current then
    visited.add(current)
  end
  for path in map[current] do
    if path != 'start' then
      if visited.include?(path) then
        if double != nil then
          # do nothing
        else
          count_paths_2(map, path, visited.dup, path)
        end
      else
        count_paths_2(map, path, visited.dup, double)
      end
    end
  end
end

count_paths(read_input(input), 'start', Set.new)
puts @total
count_paths_2(read_input(input), 'start', Set.new, nil)
puts @total_2
