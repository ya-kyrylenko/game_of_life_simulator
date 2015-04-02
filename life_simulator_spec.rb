require 'rspec'
require_relative 'life-simulator.rb'

describe "Game" do
	describe "Universe" do
		subject { Universe.new }
		it 'should create a new oject' do
			expect(subject.is_a?(Universe)).to be_truthy
		end
	end
end