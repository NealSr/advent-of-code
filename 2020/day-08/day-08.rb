input = File.readlines("input.txt")

@acc = 0
@pointer = 0

@program = []
@visited = {}

for line in input
  @program << line.split(" ")
end

@step = 0

def execute(swap)
  if @pointer == 635 then
    puts "WINNER CHICKEN DINNER: #{@acc} #{@pointer}"
  end
  if @pointer >= 636 then
  	puts "OVERFLOW: "
  	return
  end
  if @visited.has_key? @pointer then
    puts "EXITING: #{@acc} #{@pointer}"
    return
  else
    @visited[@pointer] = @step
  end
  code = @program[@pointer]
  if code[0].eql? "acc" then
  	@acc += code[1].to_i
  	@step += 1
  	@pointer += 1
  elsif code[0].eql? "jmp" then
  	if @pointer == swap then
  	  @step += 1
  	  @pointer += 1
  	else
      @pointer += code[1].to_i
  	  @step += 1
  	end
  elsif code[0].eql? "nop" then
  	@step += 1
  	@pointer += 1
  end
   	execute(swap)
end

execute(-1)

for i in 0..635
  if @program[i][0].eql? "jmp" then
  	#puts " STARTING #{i}"
  	execute(i)
  	#puts " END PROGRAM "
  	@acc = 0
    @pointer = 0
    @step = 0
    @visited = {}
  end
end