module Calculon
  class Interpreter
    def initialize(ast)
      @ast = ast
    end

    def output(tree=@ast)
      op, left, right = *tree
      left_val = if left.is_a?(Array)
                   output(left)
                 else
                   left
                 end

      right_val = if right.is_a?(Array)
                    output(right)
                  else
                    right
                  end

      case op
      when :plus then left_val + right_val
      when :sub  then left_val - right_val
      when :div  then left_val / right_val
      when :mult then left_val * right_val
      when :pow  then left_val ** right_val
      when :subexpr then left_val
      else raise "Unknown op #{op}"
      end
    end
  end
end
