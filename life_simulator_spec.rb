require 'rspec'
require_relative 'life-simulator.rb'

describe "Game" do
	let!(:universe) { Universe.new }
	let!(:cell) { Cell.new(1, 1) }
	describe "Universe class" do
		subject { Universe.new }
		# Should create a new Universe oject
		it { expect(subject).to be_a Universe }
		it { expect(subject.grid).to be_a Array }
		it { should respond_to(:rows, :columns, :grid, :cells, :randomly_recovery) }
		it 'Array must create Cell class' do
			subject.grid.each do |row|
				row.each do |colum|
					expect(colum).to be_a Cell
				end
			end
		end
		it 'Detects live neighbour to the top' do
			subject.grid[cell.y - 1][cell.x].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the top-right' do
			subject.grid[cell.y - 1][cell.x + 1].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the top-left' do
			subject.grid[cell.y - 1][cell.x - 1].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the left' do
			subject.grid[cell.y][cell.x - 1].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the right' do
			subject.grid[cell.y][cell.x + 1].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the bottom' do
			subject.grid[cell.y + 1][cell.x].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the bottom-left' do
			subject.grid[cell.y + 1][cell.x - 1].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end
		it 'Detects live neighbour to the bottom-right' do
			subject.grid[cell.y + 1][cell.x + 1].alive = true
			expect(subject.neighbours(cell).count).to eq 1
		end

		it 'Must randomly recovery our universe' do
			expect(subject.all_live_cell.count).to eq 0
			subject.randomly_recovery
			expect(subject.all_live_cell.count).to_not eq 0
		end
	end

	describe "Cell class" do
		subject{ Cell.new }
		# Should create a new Cell oject
		it { expect(subject).to be_a Cell }
		it { should respond_to(:alive, :x, :y) }
		it { expect(subject.alive).to eq false}
	end
	describe "Logic game" do
		subject { LogicGame.new }
		it { expect(subject).to be_a LogicGame }
		it { should respond_to(:universe)}
		it 'testing method for rules' do
			LogicGame.new(universe, [[0,2], [1,2]])
			expect(universe.grid[0][2].alive).to eq true
			expect(universe.grid[1][2].alive).to eq true
		end
	end
	describe "Rules of game" do
		let!(:game) { LogicGame.new }
		it 'kill a live cell with 1 neighbour' do
			game = LogicGame.new(universe, [[0, 1], [1, 1]])
			#expect(game.universe.grid[1][1].alive).to eq true
			game.step!
			game.universe.grid[1][1].should be_not_alive
			# expect(universe.grid[1][1].alive).to eq false
			expect(universe.grid[0][1].alive).to eq false
		end
		it 'Should keep alive cell with 2 neighbours' do
			game = LogicGame.new(universe, [[0, 1], [1, 1], [2, 1]])
			universe.neighbours(universe.grid[1][1]).count.should == 2
			game.step!
			universe.grid[0][1].should be_not_alive
			universe.grid[1][1].should be_alive
			universe.grid[2][1].should be_not_alive
		end
		it 'Should die cell with 4 neighbours' do
			game = LogicGame.new(universe, [[0, 1], [1, 1], [2, 1], [1, 0], [0, 2]])
			universe.neighbours(universe.grid[1][1]).count.should == 4
			game.step!
			universe.grid[1][1].should be_not_alive
		end
		it 'Should come alive cell with 3 neighbours' do
			game = LogicGame.new(universe, [[0, 1], [1, 1], [2, 1], [1, 0]])
			universe.grid[1][1].alive = false
			universe.neighbours(universe.grid[1][1]).count.should == 3
			game.step!
			universe.grid[1][1].should be_alive
		end
	end
end
