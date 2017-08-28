require 'calculon/version'
require 'calculon/tokenizer'
require 'calculon/parser'
require 'calculon/interpreter'

module Calculon
  def self.tokenize(string)
    tokenizer = Tokenizer.new(string)
    tokenizer.tokens
  end

  def self.parse(tokens)
    parser = Parser.new(tokens)
    parser.tree
  end

  def self.interpret(ast)
    interpreter = Interpreter.new(ast)
    interpreter.output
  end
end
