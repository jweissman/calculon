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
        elsif (id = scanner.scan(/\w+/))
          token_list << { id: id.to_s }
        elsif (op = scanner.scan(/[-\+*\/^=;]/))
          token_list << { op: operator_names[op.to_sym] }
        elsif (scanner.scan(/\(/))
          token_list << { parens: :left }
        elsif (scanner.scan(/\)/))
          token_list << { parens: :right }
        elsif (_space = scanner.scan(/\s/))
          # ignore
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
        :'/' => :div,
        :'^' => :pow,
        :'=' => :eq,
        :';' => :semi
      }
    end
  end

  def self.tokenize(string)
    tokenizer = Tokenizer.new(string)
    tokenizer.tokens
  end
end
