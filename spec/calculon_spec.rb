require 'spec_helper'
require 'pry'
require 'calculon'

describe Calculon do
  it 'tokenizes' do
    expect(Calculon.tokenize("1+2/3*4-5")).to eq(
      [
        { number: 1 },
        { op: :plus },
        { number: 2 },
        { op: :div },
        { number: 3 },
        { op: :mult },
        { number: 4 },
        { op: :sub },
        { number: 5 },
      ]
    )
  end

  context 'parsing' do
    it 'integers' do
      tokens = Calculon.tokenize '1' #+2+3'
      tree = Calculon.parse(tokens)
      expect(tree).to eq([factor: 1])
    end

    it 'terms' do
      tokens = Calculon.tokenize('2*2+1')
      tree = Calculon.parse(tokens)
      expect(tree).to eq( [:plus, [ :mult, 2, 2 ], 1])
    end
  end

  context 'interpreting' do
    it 'evals' do
      tokens = Calculon.tokenize('1+2*3+1')
      tree = Calculon.parse(tokens)
      result = Calculon.interpret(tree)
      expect(result).to eq(8)
    end
  end
end
