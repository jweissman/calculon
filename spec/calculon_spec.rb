require 'spec_helper'
require 'calculon'

describe Calculon do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).to_not be_empty
  end
end