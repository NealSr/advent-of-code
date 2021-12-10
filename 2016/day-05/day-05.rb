INPUT = "ugkcyxxp"
require 'digest'

password = []
for index in 0.. do
  md5 = Digest::MD5.hexdigest INPUT + index.to_s
  if md5.start_with? '00000'
    password << md5[5]
    puts "Found: #{index}, md5=#{md5}"
  end
  break if password.length == 8
end

puts password.join



password2 = ["_","_","_","_","_","_","_","_"]
for index in 0.. do
  md5 = Digest::MD5.hexdigest INPUT + index.to_s
  if md5.start_with? '00000'
    position = if md5[5].ord >= 48 && md5[5].ord <= 56 then md5[5].to_i else 9 end
    character = md5[6]
    if position < 8 && password2[position] == "_" then
      password2[position] = character
      puts "Found: #{index}, md5=#{md5}"
      puts password2.join
    end
  end
  break if !password2.include?("_")
end

puts password2.join