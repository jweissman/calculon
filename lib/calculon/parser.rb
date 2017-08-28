module Calculon
  class Parser
    def initialize(tokens)
      @input_tokens = tokens
    end

    def tree
      @ast ||= expression #(@input_tokens)
    end

    def expression
      tree = term
      while peek && (peek[:op] == :plus || peek[:op] == :sub)
        tree = [ consume[:op], tree, term ]
      end
      tree
    end

    def term
      tree = factor
      while peek && (peek[:op] == :mult || peek[:op] == :div)
        tree = [ consume[:op], tree, factor ]
      end
      tree
    end

    def factor
      if peek && peek[:number]
        consume[:number]
      # elsif peek && peek[:lparens]
      #   consume[:lparens]
      #   subexpr = expression
      #   consume[:rparens]
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
