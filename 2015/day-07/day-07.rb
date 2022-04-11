class Circuit
    TRANSFORMS = {
      "LSHIFT"         => "<<",
      "RSHIFT"         => ">>",
      "NOT"            => "~",
      "AND"            => "&",
      "OR"             => "|",
      /\b(if|do|in)\b/ => "\\1_",
    }
  
    def add(line)
      TRANSFORMS.each do |from, to|
        line.gsub!(from, to)
      end
  
      expr, name = line.strip.split(" -> ")
  
      method = "def #{name}; @#{name} ||= #{expr}; end"
  
      puts method
      instance_eval method
    end
  end
  
  circuit = Circuit.new
  open("input.txt").each_line { |line| circuit.add(line) }
  circuit.add("956 -> b")
  p circuit.a