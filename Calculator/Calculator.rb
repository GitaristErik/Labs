require_relative 'OperationsBinary'
require_relative 'OperationsUnary'

class Calculator
  def start
    puts 'Calculator has started!'.cyan
    loop do
      read_input
      puts 'Calculation result:'.cyan
      puts $a.to_s.magenta unless ($a = @op_b[@o].execute).nil?
    end
  end

  private

  def initialize
    @op_b = OperationsBinary.operations
    @op_u = OperationsUnary.operations
  end

  def read_input
    puts 'Enter the left operand:'.blue if $a.nil?
    $a = read_input_unary($a ||= read_input_operand)
    puts 'Enter the operation:'.blue
    @o = read_input_operation
    puts 'Enter the right operand:'.blue
    $b = read_input_unary read_input_operand
  end

  def read_input_operand
    res = nil
    until (res.is_a? Integer) || (res.is_a? Float)
      a = gets.chomp
      b = a.to_f
      if b == 0.0
        if a[0] == '0'
          res = res.nil? ? 0 : @op_u[res].execute(0)
        else
          k = a.to_sym
          if @op_u.key? k
            if k == :pop
              s = @op_u[k].execute(nil)
              return s unless s.nil?
            else
              res = k
            end
          else
            puts 'Incorrect entry, please try again:'.red
          end
        end
      else
        res = res.nil? ? b : @op_u[res].execute(b)
      end
    end
    res
  end

  def read_input_unary(res)
    puts "Input the unar operator or press 'enter':"
    a = gets.chomp.to_sym
    until a == :''
      if @op_u.key? a
        res = @op_u[a].execute res
      else
        puts 'Incorrect entry, please try again:'.red
      end
      a = gets.chomp.to_sym
    end
    res
  end

  def read_input_operation
    res = nil
    while res.nil?
      a = gets.chomp.to_sym
      if @op_b.key? a
        res = a
      else
        puts 'Incorrect entry, please try again:'.red
      end
    end
    res
  end
end

c = Calculator.new
c.start
