input = File.readlines(if ARGV[0] == "test" then "sample.txt" else "input.txt" end)

def is_valid(number)
  for char in number.to_s.chars
    if char.to_i == 0 then
      return false
    end
  end
  return number.to_s.length == 14
end

@monad = []

for line in input do
  @monad << line.split(" ")
end

@vars = ["w","x","y","z"]

def is_model(input)
  idx = 0
  state = {
    "w" => 0,
    "x" => 0,
    "y" => 0,
    "z" => 0
  }

  for command in @monad do
    case command[0]
    when "inp"
      state[command[1]] = input[idx].to_i
      idx += 1
    when "add"
      a = state[command[1]]
      b = @vars.include?(command[2]) ? state[command[2]] : command[2].to_i
      state[command[1]] = a+b
    when "mul"
      a = state[command[1]]
      b = @vars.include?(command[2]) ? state[command[2]] : command[2].to_i
      state[command[1]] = a*b
    when "div"
        a = state[command[1]]
        b = @vars.include?(command[2]) ? state[command[2]] : command[2].to_i
        state[command[1]] = a/b
      when "mod"
        a = state[command[1]]
        b = @vars.include?(command[2]) ? state[command[2]] : command[2].to_i
        state[command[1]] = a%b  
    when "eql"
        a = state[command[1]]
        b = @vars.include?(command[2]) ? state[command[2]] : command[2].to_i
        if a == b then
          state[command[1]] = 1
        else
          state[command[1]] = 0
        end  
    end
  end
  return state["z"] == 0
end

# for number in 97919997999999.downto(11111111111111) do
#   if number % 10000 == 0 then puts number end
#   if is_valid(number) then
#     if is_model(number.to_s.chars) then
#       puts number
#       break
#     end
#   end
# end

for number in 51619131111111..99999999999999 do
    if number % 10000 == 0 then puts number end
    if is_valid(number) then
      if is_model(number.to_s.chars) then
        puts number
        break
      end
    end
  end