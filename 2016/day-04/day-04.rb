#!/usr/bin/env ruby

input = File.read("input.txt")

Room = Struct.new(:name, :id, :checksum)

rooms = input.gsub('-', '').split("\n").map do |room|
  name = room.match(/[a-z]*/)[0]
  id   = room.match(/\d{3}/)[0].to_i
  checksum = room.match(/\[([a-z]{5})\]/)[1]

  Room.new(name, id, checksum)
end

real_rooms = rooms.select do |room|
  chars = room.name.chars

  counts = {}

  chars.uniq.each do |char|
    counts[char] = room.name.count(char)
  end

  expected_checksum = counts.
    sort_by { |char, count| [-count, char] }.
    first(5).map(&:first).join

  expected_checksum == room.checksum
end

puts real_rooms.inject(0) { |sum, room| sum + room.id }

input.split("\n").map do |room|
  name = room.match(/[a-z-]*/)[0]
  id   = room.match(/\d{3}/)[0].to_i

  cipher = ('a'..'z').to_a.rotate(id % 26)

  decrypted_name = name.tr(('a'..'z').to_a.join, cipher.join)

  puts "#{decrypted_name} #{id}" if decrypted_name.include?("north")
end