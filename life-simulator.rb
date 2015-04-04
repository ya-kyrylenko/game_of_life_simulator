class Universe
	attr_accessor :rows, :columns, :grid, :cells
	def initialize(rows = 3, columns = 3)
		@rows = rows
		@columns = columns
		@cells = []
		@grid = Array.new(rows) { |row| Array.new(columns) do |column|
			cell = Cell.new(column, row)
			cells << cell
			cell
		 	end}
	end

	def neighbours(cell)
		live_neighbours = []
		# Detects a neighbour on top
		if cell.y > 0
			neighbour = self.grid[cell.y - 1][cell.x]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on top-left
		if cell.y > 0 and cell.x > 0
			neighbour = self.grid[cell.y - 1][cell.x - 1]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on top-right
		if cell.y > 0 and cell.x < (columns - 1)
			neighbour = self.grid[cell.y - 1][cell.x + 1]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on left
		if cell.x > 0
			neighbour = self.grid[cell.y][cell.x - 1]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on right
		if cell.x < (columns - 1)
			neighbour = self.grid[cell.y][cell.x + 1]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on bottom
		if cell.y < (rows - 1)
			neighbour = self.grid[cell.y + 1][cell.x]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on bottom-left
		if cell.y < (rows - 1) and cell.x > 0
			neighbour = self.grid[cell.y + 1][cell.x - 1]
			live_neighbours << neighbour if neighbour.alive?
		end
		# Detects a neighbour on bottom-right
		if cell.y < (rows - 1) and cell.x < (columns - 1)
			neighbour = self.grid[cell.y + 1][cell.x + 1]
			live_neighbours << neighbour if neighbour.alive?
		end
		live_neighbours
	end
	def all_live_cell
		cells.select { |cell| cell.alive}
	end

	def randomly_recovery
		cells.each do |cell|
			cell.alive =  rand > 0.6 ? false : true
		end
	end
end


class Cell
	attr_accessor :alive, :x, :y
	def initialize(x = 0, y = 0)
		@alive = false
		@x = x
		@y = y
	end

	def alive?
		alive
	end

	def not_alive?
		!alive
	end

	def die!
		@alive = false
	end

	def come_to_alive!
		@alive = true
	end
end


class LogicGame
	attr_accessor :universe, :fortestcells, :cycles
	def initialize(universe = Universe.new, fortestcells = [])
		@universe = universe
		@fortestcells = fortestcells

		fortestcells.each do |testcell|
			# testseel[0] - y, testcell[1] - x.
			universe.grid[testcell[0]][testcell[1]].alive = true
		end
		@cycles = 0
	end

	def step!
		@cycles += 1
		will_live_cells = []
		will_die_cells = []
		universe.cells.each do |cell|
			# Rules 1
			if cell.alive? && universe.neighbours(cell).count < 2
				will_die_cells << cell
			end
			# Rules 2
			if cell.alive? && universe.neighbours(cell).count > 3
				will_die_cells << cell
			end
			# Rules 3
			if cell.alive? && ([2, 3].include? universe.neighbours(cell).count)
				will_live_cells << cell
			end
			# Rules 4
			if cell.not_alive? && universe.neighbours(cell).count == 3
				will_live_cells << cell
			end
		end
		will_live_cells.each { |cell|
			cell.come_to_alive!
		}
		will_die_cells.each { |cell|
			cell.die!
		}
	end
end