class Universe
	attr_accessor :rows, :columns, :grid
	def initialize(rows=3, columns=3)
		@rows = rows
		@columns = columns
		@grid = Array.new(rows) { Array.new(columns) { Cell.new} }
	end
end

class Cell
	attr_accessor :alive
	def initialize
		@alive = false
	end
end
