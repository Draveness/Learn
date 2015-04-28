# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces =  [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               	   rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
	               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
	               [[0, 0], [0, -1], [0, 1], [0, 2]]],
	               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
	               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
	               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
	               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
	               rotations([[0, 0], [0, 1], [1, 0], [2, 1], [1, 1]]),
	               rotations([[0, 0], [0, 1], [1, 0]]), # Triangle
	               [[[0, 0], [-1, 0], [-2, 0], [1, 0], [2, 0]], # long(5) (only needs two)
	               [[0, 0], [0, -1], [0, -2], [0, 1], [0, 2]]]]
  # your enhancements here
  def initialize(point_array, board)
    super(point_array, board)
  end

  def self.next_piece (board)
  	if board.cheat_mode == true
  		board.cheat_mode = false
    	MyPiece.new([[[0,0]]], board)  			
  	else
    	MyPiece.new(All_My_Pieces.sample, board)  			
  	end
  end
end

class MyBoard < Board
  # your enhancements here
  attr_accessor :cheat_mode, :score

  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheat_mode = false
  end

  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position

    (0..(locations.size - 1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris
  # your enhancements here
  def initialize
  	super
  	key_bindings_enhanced
  end

  def key_bindings_enhanced
  	@root.bind('u', proc do 
  		@board.rotate_clockwise
  		@board.rotate_clockwise
		@board.drop_all_the_way  		
  	end)
  	@root.bind('c', proc do
  		if @board.score >= 100 and not @board.cheat_mode
  			@board.score -= 100
  			@board.cheat_mode = true
  		end
  	end)
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

end


