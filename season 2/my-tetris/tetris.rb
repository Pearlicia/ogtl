require 'gosu'

# Constants
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480
BLOCK_SIZE = 20
ROWS = WINDOW_HEIGHT / BLOCK_SIZE
COLUMNS = WINDOW_WIDTH / BLOCK_SIZE

# Colors
BLACK = Gosu::Color.new(0xff000000)
WHITE = Gosu::Color.new(0xffffffff)
GRAY = Gosu::Color.new(0xff808080)
RED = Gosu::Color.new(0xffff0000)
GREEN = Gosu::Color.new(0xff00ff00)
BLUE = Gosu::Color.new(0xff0000ff)
YELLOW = Gosu::Color.new(0xffffff00)

# Shapes
SHAPES = [
  [[1, 1, 1],
   [0, 1, 0]],
  [[0, 2, 2],
   [2, 2, 0]],
  [[3, 3, 0],
   [0, 3, 3]],
  [[4, 0, 0],
   [4, 4, 4]],
  [[0, 0, 5],
   [5, 5, 5]],
  [[6, 6],
   [6, 6]],
  [[7, 7, 7, 7]]
]

# Game logic
class Game
  def initialize
    @board = Array.new(ROWS) { Array.new(COLUMNS, 0) }
    @current_shape = nil
    @current_shape_row = nil
    @current_shape_column = nil
    @score = 0
    new_shape
  end

  def new_shape
    @current_shape = SHAPES.sample
    @current_shape_row = 0
    @current_shape_column = COLUMNS / 2 - @current_shape.first.length / 2
    if @board_collision
      exit
    end
  end

  def update
    if @board_collision
      new_shape
    else
      @current_shape_row += 1
      if @board_collision
        @current_shape_row -= 1
        place_current_shape_on_board
        remove_completed_rows
        new_shape
      end
    end
  end

  def draw
    draw_board
    draw_current_shape
  end

  def move_left
    if !@board_collision(-1)
      @current_shape_column -= 1
    end
  end

  def move_right
    if !@board_collision(1)
      @current_shape_column += 1
    end
  end

  def rotate
    rotated_shape = @current_shape.transpose.map(&:reverse)
    if !@board_collision(0, 0, rotated_shape)
      @current_shape = rotated_shape
    end
  end

  private

  def draw_board
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        draw_block(column_index, row_index, cell)
      end
    end
  end

  def draw_current_shape
    @current_shape.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell != 0
          draw_block(@current_shape_column + column_index, @current_shape_row + row_index, cell)
        end
      end
    end
  end

  def draw_block(column, row, color)
    x = column * BLOCK_SIZE
