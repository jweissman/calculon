module Calculon
  class Interpreter
    def initialize(ast, context:)
      @ast = ast
      @context = context
    end

    def output(tree=@ast)
      op, left, right = *tree
      left_val = if left.is_a?(Array)
                   output(left)
                 elsif left.is_a?(String)
                   if @context.has_key?(left.to_sym)
                     @context[left.to_sym]
                   else
                     left
                   end
                 else
                   left
                 end

      right_val = if right.is_a?(Array)
                    output(right)
                  elsif right.is_a?(String)
                    if @context.has_key?(right.to_sym)
                      @context[right.to_sym]
                    else
                      right
                    end
                  else
                    right
                  end

      case op
      when :plus then left_val + right_val
      when :sub  then left_val - right_val
      when :div  then left_val / right_val
      when :mult then left_val * right_val
      when :pow  then left_val ** right_val
      when :eq   then
        @context[left_val.to_sym] = right_val
        # return right_val #{ left_val.to_sym => right_val } #@context.slice(left_val.to_sym)
      when :subexpr then left_val
      when :semi then
        # only return 'last' result...
        # binding.pry
        # [ left_val, right_val ].flatten(1)
        right_val
      else raise "Unknown op #{op}"
      end
    end
  end
end
