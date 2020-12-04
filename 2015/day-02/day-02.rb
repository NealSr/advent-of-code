boxes = File.readlines("input.txt")

total_paper = 0
total_ribbon = 0

for box in boxes
  sides = box.split("x")
  l = sides[0].to_i
  w = sides[1].to_i
  h = sides[2].to_i
  lw = l * w
  lh = l * h
  wh = w * h
  paper = 2 * (lw + lh + wh) + [lw, lh, wh].min
  ribbon = 2 * (l + w + h - [l, w, h].max) + (l * w * h)
  total_paper += paper
  total_ribbon += ribbon
end
puts total_paper
puts total_ribbon