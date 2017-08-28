require 'spec_helper'
require 'pry'
require 'calculon'

describe Calculon do
  it 'tokenizes' do
    expect(Calculon.tokenize("1+2/3*(4-5)^6")).to eq(
      [
        { number: 1 },
        { op: :plus },
        { number: 2 },
        { op: :div },
        { number: 3 },
        { op: :mult },
        { parens: :left },
        { number: 4 },
        { op: :sub },
        { number: 5 },
        { parens: :right },
        { op: :pow },
        { number: 6 }
      ]
    )
  end

  context 'parsing' do
    it 'integers' do
      tokens = Calculon.tokenize '1'
      tree = Calculon.parse(tokens)
      expect(tree).to eq(1)
    end

    it 'terms' do
      tokens = Calculon.tokenize('2*2+1')
      tree = Calculon.parse(tokens)
      expect(tree).to eq( [:plus, [ :mult, 2, 2 ], 1])
    end

    it 'parens' do
      tokens = Calculon.tokenize('8*(4/2)')
      tree = Calculon.parse(tokens)
      expect(tree).to eq(
        [ :mult, 8, [ :subexpr, [:div, 4, 2]]]
      )
    end

  end

  context 'interpreting' do
    it 'computes' do
      tokens = Calculon.tokenize('1+2*3+1')
      tree = Calculon.parse(tokens)
      result = Calculon.interpret(tree)
      expect(result).to eq(8)
    end

    it 'handles parens' do
      tokens = Calculon.tokenize('(1+2)*(3+1)')
      tree = Calculon.parse(tokens)
      result = Calculon.interpret(tree)
      expect(result).to eq(12)
    end
  end

  context 'evaluate' do
    it 'chains ops' do
      result = Calculon.evaluate('8 / 4 + 2 * 2')
      expect(result).to eq(6)
    end

    it 'handles parens and exponents' do
      result = Calculon.evaluate('2 ^ (1 + 2)')
      expect(result).to eq(8)
    end
  end
end
