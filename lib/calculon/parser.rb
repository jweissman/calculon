module Calculon
  class Parser
    def initialize(tokens)
      @input_tokens = tokens
    end

    def tree
      @ast ||= stmt_list #(@input_tokens)
    end

    def stmt_list
      tree = formula
      while peek && peek[:op] == :semi
        tree = [ consume[:op], tree, formula ]
      end
      tree
    end

    def formula
      tree = expression
      if peek && peek[:op] == :eq
        tree = [ consume[:op], tree, expression ]
      end
      tree
    end

    def expression
      tree = term
      while peek && (peek[:op] == :plus || peek[:op] == :sub)
        tree = [ consume[:op], tree, term ]
      end
      tree
    end

    def term
      tree = power
      while peek && (peek[:op] == :mult || peek[:op] == :div)
        tree = [ consume[:op], tree, power ]
      end
      tree
    end

    def power
      tree = factor
      while peek && (peek[:op] == :pow)
        tree = [ consume[:op], tree, factor ]
      end
      tree
    end

    def factor
      if peek && peek[:number]
        consume[:number]
      elsif peek && peek[:parens] == :left
        consume[:parens]
        subexpr = expression
        raise 'Unmatched parens' unless peek[:parens] == :right
        consume[:parens]
        [ :subexpr, subexpr ]
      elsif peek && peek[:id]
        consume[:id]
      # else
      #   raise "Expected #{peek} to be a number, left parens or id"
      end
    end

    private

    def peek
      @input_tokens.first
    end

    def consume
      @input_tokens.shift
    end
  end
end
