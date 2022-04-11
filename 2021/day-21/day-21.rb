input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

p1_pos = input[0].split(" ")[4].to_i
p1_score = 0
p2_pos = input[1].split(" ")[4].to_i
p2_score = 0

die_roll = 0

def get_score(moves)
  board = [1,2,3,4,5,6,7,8,9,10]
  return board[moves % 10 - 1]
end

#while (p1_score < 1000 && p2_score < 1000) do
for i in 1..2000 do
  r1 = die_roll < 100 ? die_roll+=1 : die_roll=1
  r2 = die_roll < 100 ? die_roll+=1 : die_roll=1
  r3 = die_roll < 100 ? die_roll+=1 : die_roll=1
  moves = [r1,r2,r3].sum
  if i % 2 == 0 then
    p2_pos += moves
    p2_score += get_score(p2_pos)
    puts "Player 2 rolls #{r1},#{r2},#{r3} and moves to space #{get_score(p2_pos)} for a total score of #{p2_score}"
  else
    p1_pos += moves
    p1_score += get_score(p1_pos)
    puts "Player 1 rolls #{r1},#{r2},#{r3} and moves to space #{get_score(p1_pos)} for a total score of #{p1_score}"
  end
  if p1_score >= 1000 || p2_score >= 1000 then
    puts "Turn: #{i} - Player 1: #{p1_score} Player 2: #{p2_score}"
    puts [p1_score, p2_score].min * i * 3
    break
  else
    puts "Turn: #{i} - Player 1: #{p1_pos}, #{p1_score} Player 2: #{p2_pos}, #{p2_score}"
  end
end

p1_pos = input[0].split(" ")[4].to_i
p1_score = 0
p2_pos = input[1].split(" ")[4].to_i
p2_score = 0

turn = 0
universes = {}
universes[[p1_pos, p2_pos, 0, 0]] = 1

possible_rolls = {}
for d1 in 1..3
  for d2 in 1..3
    for d3 in 1..3
      sum = [d1,d2,d3].sum
      if possible_rolls.include?(sum) then
        possible_rolls[sum] += 1
      else
        possible_rolls[sum] = 1
      end
    end
  end
end

pp universes
pp possible_rolls

in_progress = true
while in_progress do
  in_progress = false
  next_step = {}
  for key in universes.keys do
    p1,p2,s1,s2 = key[0],key[1],key[2],key[3]
    if [s1,s2].max < 21 then
      in_progress = true
      for roll, times in possible_rolls do
        p1,p2,s1,s2 = key[0],key[1],key[2],key[3]
        if turn == 0 then
          p1 = (p1 - 1 + roll) % 10 + 1
          s1 += p1
        else
          p2 = (p2 - 1 + roll) % 10 + 1
          s2 += p2
        end
        new_key = [p1,p2,s1,s2]
        if next_step.include?(new_key) then
          next_step[new_key] += possible_rolls[roll] * universes[key]
        else
          next_step[new_key] = possible_rolls[roll] * universes[key]
        end
      end
    else
      if universes.include?(key) then
        if next_step.include?(key) then
          next_step[key] += universes[key]
        else
          next_step[key] = universes[key]
        end  
      end
    end
  end
  puts "#{turn+1}. #{next_step.length} #{next_step.values.sum}"
  universes = next_step
  turn = (turn + 1) % 2
end

win1 = []
for key, count in universes do
  if key[2] >= 21 then
    win1 << count
  end
end
win2 = []
for key, count in universes do
  if key[3] >= 21 then
    win2 << count
  end
end
puts win1.sum
puts win2.sum