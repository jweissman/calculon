module Calculon
  class Tokenizer
    def initialize(input)
      @input = input
    end

    def tokens
      scanner = StringScanner.new(@input)
      token_list = []
      until scanner.eos?
        if (num = scanner.scan(/\d+/))
          token_list << { number: num.to_i }
        elsif (op = scanner.scan(/[-\+*\/]/))
          token_list << { op: operator_names[op.to_sym] }
        else
          raise "Could not parse '#{@input}' (at #{scanner.pos}: '#{@input[scanner.pos]}')"
        end
      end
      token_list
    end

    def operator_names
      { :'+' => :plus,
        :'-' => :sub,
        :'*' => :mult,
        :'/' => :div
      }
    end
  end

  def self.tokenize(string)
    tokenizer = Tokenizer.new(string)
    tokenizer.tokens
  end
end
