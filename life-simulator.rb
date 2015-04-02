class Universe
	attr_accessor :rows, :columns, :grid
	def initialize(rows=5, columns=5)
		@rows = rows
		@columns = columns
		@grid = Array.new(rows) { Array.new(columns) {} }
	end
end