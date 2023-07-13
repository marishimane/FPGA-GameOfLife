class GameOfLife
	attr_accessor :board, :rows, :cols

	def initialize(board)
		@board = board
		@rows = board.length
		@cols = board[0].length
	end

	def live_neighbors(i, j)
		live_neighbors = 0
		[-1, 0, 1].product([-1, 0, 1]).each do |x, y|
			next if x.zero? && y.zero?
			new_i, new_j = i + x, j + y
			live_neighbors += 1 if new_i.between?(0, @rows - 1) && new_j.between?(0, @cols - 1) && @board[new_i][new_j] == 1
		end
		live_neighbors
	end

	def next_step
		new_board = Array.new(@rows) { Array.new(@cols) }

		@rows.times do |i|
			@cols.times do |j|
				live_neighbors = live_neighbors(i, j)

				if @board[i][j] == 1
					new_board[i][j] = (live_neighbors < 2 || live_neighbors > 3) ? 0 : 1
				else
					new_board[i][j] = live_neighbors == 3 ? 1 : 0
				end
			end
		end

		@board = new_board
	end

	def run_simulation(steps)
		steps.times { next_step }
		@board
	end
end

initial_board = [
	[0, 0, 0],
	[0, 0, 1],
	[1, 1, 1]
]
initial_board.each { |row| puts row.join(" ") }

game = GameOfLife.new(initial_board)
steps = 10
final_board = game.run_simulation(steps)

puts "Final board after #{steps} steps:"
final_board.each { |row| puts row.join(" ") }
