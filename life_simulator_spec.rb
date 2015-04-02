require 'rspec'
require_relative 'life-simulator.rb'

describe "Game" do
	describe "Universe" do
		subject { Universe.new }
		# Should create a new oject
		it { expect(subject.is_a?(Universe)).to be_truthy }
		it { expect(subject.grid.is_a?(Array)).to be_truthy }
		it { should respond_to(:rows, :columns, :grid) }

	end
end