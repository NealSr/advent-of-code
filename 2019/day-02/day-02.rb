noun = 0
verb = 0
end_state = 0

for noun in 0..99 do
  for verb in 0..99 do
    input = File.readlines('input.txt')[0].split(',').map(&:to_i)
    input[1] = noun
    input[2] = verb

    for i in 0..40 do
      command = input[i * 4]
      x = input[i * 4 + 1]
      y = input[i * 4 + 2]
      res = input[i * 4 + 3]
      case command
        when 1
          input[res] = input[x] + input[y]
        when 2
          input[res] = input[x] * input[y]
        when 99
          if input[0] == 3101878 || input[0] == 19690720 then
            puts noun,verb,input[0]
            break
          end
      end
    end
  end
end