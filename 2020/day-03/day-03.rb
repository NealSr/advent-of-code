trees = File.readlines('input.txt')

xpos = 0
ypos = 0

tree_count = 0

for i in 0..trees.length - 1
  if trees[ypos][xpos].eql?'#' then
    tree_count += 1
  end
  puts tree_count
  xpos += 1
  ypos += 2
  if xpos > 30 then xpos -= 31 end
end
