require 'rspec'
require_relative 'life-simulator.rb'

describe "Game" do
	describe "Universe class" do
		subject { Universe.new }
		# Should create a new Universe oject
#		it { expect(subject.is_a?(Universe)).to be_truthy }
		it { expect(subject).to be_a Universe }
#		it { expect(subject.grid.is_a?(Array)).to be_truthy }
		it { expect(subject.grid).to be_a Array }
		it { should respond_to(:rows, :columns, :grid) }
		it 'Array must create Cell class' do
			subject.grid.each do |row|
				row.each do |colum|
					expect(colum).to be_a Cell
				end
			end
		end
	end

	describe "Cell class" do
		subject{ Cell.new }
		# Should create a new Cell oject
		it { expect(subject).to be_a Cell }
		it { should respond_to(:alive) }
		it { expect(subject.alive).to eq false}
	end
end