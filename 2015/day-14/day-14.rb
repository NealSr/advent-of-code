input = File.readlines('input.txt')

class Deer
    attr_accessor :current_distance, :points
    def initialize(distance, fly_duration, rest_duration)
      @distance = distance.to_i
      @duration = {fly: fly_duration, rest: rest_duration}
      @internal_time = @current_distance = @points = 0
      @mode = :fly
    end
    def change_mode
      @mode = (@mode == :fly) ? :rest : :fly
      @internal_time = 1
    end
    def fly
      @internal_time += 1
      change_mode if @internal_time > @duration[@mode]
      @current_distance += @distance if (@mode == :fly)
    end
  end
  
  deer = []
  
  for line in input do
    data = line.split
    name, speed, duration, rest = data[0], data[3].to_i, data[6].to_i, data[13].to_i
    deer << Deer.new(speed, duration, rest)
  end

  2503.times do 
    deer.each {|d| d.fly }
    deer.max_by(&:current_distance).points += 1
  end

  p deer.max_by(&:current_distance).current_distance
  p deer.max_by(&:points).points