class OperationsUnary
  class UCommand
    def execute(n)
      raise 'Operation not implemented!'
    end
  end

  class UCommandIncrement < UCommand
    def execute(n)
      puts n += 1
      n
    end
  end

  class UCommandDecrement < UCommand
    def execute(n)
      puts n -= 1
      n
    end
  end

  class UCommandSqrt < UCommand
    def execute(n)
      if n < 0
        puts 'Error! It is impossible to calculate the sqrt of a negative number'.red
      else
        puts n = Math.sqrt(n)
      end
      n
    end
  end

  class UCommandSin < UCommand
    def execute(n)
      puts n = Math.sin(n)
      n
    end
  end

  class UCommandCos < UCommand
    def execute(n)
      puts n = Math.cos(n)
      n
    end
  end

  class UCommandTan < UCommand
    def execute(n)
      puts n = Math.tan(n)
      n
    end
  end

  class UCommandCTan < UCommand
    def execute(n)
      puts n = 1 / Math.tan(n)
      n
    end
  end

  class UCommandExp < UCommand
    def execute(n)
      puts n = Math.exp(n)
      n
    end
  end

  class UCommandLn < UCommand
    def execute(n)
      if n < 0
        puts 'Error! It is impossible to calculate the natural logarithm of a negative number'.red
      else
        a = Math.log(n)
        if a.to_s == 'infinity'
          puts "Error! Then the natural logarithm will be equal to infinity!".red
        else
          puts n = a
        end
      end
      n
    end
  end

  class UCommandFactorial < UCommand
    def execute(n)
      if n < 0
        puts "Error! Factorial of negative number cannot be calculated!".red
      elsif n > 100
        puts "Error! Too large number entered".red
      else
        puts n = fact(n)
      end
      n
    end

    private

    def fact(n)
      return 1 if n == 0
      n * fact(n - 1)
    end
  end

  class UCommandPop < UCommand
    def execute(x)
      n = OperationsBinary.stack
      if n.empty?
        puts "Error! The stack is empty!".red
        x
      else
        puts n.last
        n.pop
      end
    end
  end

  class UCommandPush < UCommand
    def execute(n)
      OperationsBinary.stack.push n
      n
    end
  end

  class UCommandMW < UCommand
    def execute(n)
      if OperationsUnary.memory.nil?
        puts "value #{n} saved!".cyan
      else
        if OperationsUnary.memory == n
          puts "Value #{n} has already written!".cyan
        else
          puts "Value #{n} overwritten last value #{OperationsUnary.memory}".cyan
        end
      end
      OperationsUnary.memory = n
    end
  end

  class UCommandMR < UCommand
    def execute(n)
      if OperationsUnary.memory.nil?
        puts "Error! No stored value!".red
        n
      else
        puts c = OperationsUnary.memory
        OperationsUnary.memory = nil
        c
      end
    end
  end

  @operations = {
    '--': UCommandIncrement.new,
    '++': UCommandDecrement.new,
    sqrt: UCommandSqrt.new,
    sin: UCommandSin.new,
    cos: UCommandCos.new,
    tan: UCommandTan.new,
    ctan: UCommandCTan.new,
    exp: UCommandExp.new,
    ln: UCommandLn.new,
    '!': UCommandFactorial.new,
    pop: UCommandPop.new,
    push: UCommandPush.new,
    mw: UCommandMW.new,
    mr: UCommandMR.new
  }

  class << self
    attr_reader :operations
    attr_accessor :memory
  end
end
