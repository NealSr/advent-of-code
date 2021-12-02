others = File.readlines("input.txt").sort

seats = []

for seat in others
  i = 0
  binary_row = "00"
  binary_seat = "0"
  seat.each_char { |chr|  
    if chr.eql?"B" then
      binary_row << "1"
    elsif chr.eql?"F" then
      binary_row << "0"
    end
    if chr.eql?"L" then
      binary_seat << "0"
    elsif chr.eql?"R" then
      binary_seat << "1"
    end  	
  }
  seats << "#{binary_row.to_i(2) * 8 + binary_seat.to_i(2)}".to_i
end

puts seats.max

puts "-----"

(45..816).each { |seat|
  if seats.include? seat then
  	# do nothing
  else
  	puts seat
  end
}