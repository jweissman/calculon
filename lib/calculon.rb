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

  def self.interpret(ast, ctx={})
    interpreter = Interpreter.new(ast, context: ctx)
    interpreter.output
  end

  def self.evaluate(str)
    tokens = tokenize str
    tree = parse tokens
    interpret tree
  end
end
