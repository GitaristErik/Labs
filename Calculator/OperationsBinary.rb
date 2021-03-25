require_relative 'Colorize'

$a = nil
$b = nil

class OperationsBinary
  class Command
    def execute
      raise 'Operation not implemented!'
    end
  end

  class CommandPlus < Command
    def execute
      $a + $b
    end
  end

  class CommandMinus < Command
    def execute
      $a - $b
    end
  end

  class CommandMulti < Command
    def execute
      $a * $b
    end
  end

  class CommandDivide < Command
    def execute
      return puts 'Error! Division by zero is not possible!'.red if $b == 0

      $a / $b
    end
  end

  class CommandMod < Command
    def execute
      $a % $b
    end
  end

  class CommandPow < Command
    def execute
      $a**$b
    end
  end

  class CommandPrime < Command
    require 'prime'
    def execute
      OperationsBinary.stack += (Prime.take_while { |x| x <= $b }).delete_if { |x| x < $a }
      OperationsBinary.stack.empty? ? (puts 'No primes found!'.red) : OperationsBinary.stack.last
    end
  end

  @operations = {
    '+': CommandPlus.new,
    '-': CommandMinus.new,
    '*': CommandMulti.new,
    '/': CommandDivide.new,
    mod: CommandMod.new,
    pow: CommandPow.new,
    prime: CommandPrime.new
  }

  @stack = []
  class << self
    attr_reader :operations
    attr_accessor :stack
  end
end
