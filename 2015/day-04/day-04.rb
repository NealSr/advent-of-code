require 'digest'

for i in 0..1000000000
  hash = Digest::MD5.hexdigest("yzbqklnj#{i}")
  if hash.start_with?"00000" then
  	puts i
  	puts hash
  end
end