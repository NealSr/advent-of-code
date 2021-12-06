def create_boards(lines)
    boards = [[]]
    current_board = 0
    lines.drop(2).map do |line|
      if line == ''
        current_board += 1
        boards[current_board] = []
        next
      end
      boards[current_board] << line.split
    end
    boards
  end

def is_bingo(board)
  row_bingo = board.any? do |row|
    row.all? { |i| i == true }
  end
  column_bingo = board.transpose.any? do |column|
    column.all? { |i| i == true }
  end
  if row_bingo || column_bingo then puts "BINGO" end
  return row_bingo || column_bingo
end

def play_bingo(inputs, boards)
    found = false
    winning_boards = []
    inputs.each do |bingo_option|
      break if found
  
      indexes_to_delete = []
      (0...boards.size).each do |board_index|
        boards[board_index].each do |row|
          row.each_with_index do |elem, i|
            row[i] = true if elem == bingo_option
          end
        end
        next unless is_bingo(boards[board_index])
  
        sum = boards[board_index].flatten.reject { |i| i == true }.map(&:to_i).sum
        winning_boards << [sum * bingo_option.to_i, boards[board_index]]
        indexes_to_delete << board_index
      end
      indexes_to_delete.sort.reverse.each do |i|
        boards.delete_at(i)
      end
      found = true if boards.empty?
    end
    winning_boards
end

input = File.readlines('input.txt')
moves = input[0].split(',').map(&:to_i)
boards = create_boards(input)

puts moves.length
puts boards.length
puts boards[25][0]

puts play_bingo(moves, boards)[0]