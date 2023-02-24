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

    y = row * BLOCK_SIZE
    case color
    when 1
      draw_quad(x, y, YELLOW, x + BLOCK_SIZE, y, YELLOW, x, y + BLOCK_SIZE, YELLOW, x + BLOCK_SIZE, y + BLOCK_SIZE, YELLOW)
    when 2
      draw_quad(x, y, BLUE, x + BLOCK_SIZE, y, BLUE, x, y + BLOCK_SIZE, BLUE, x + BLOCK_SIZE, y + BLOCK_SIZE, BLUE)
    when 3
      draw_quad(x, y, GREEN, x + BLOCK_SIZE, y, GREEN, x, y + BLOCK_SIZE, GREEN, x + BLOCK_SIZE, y + BLOCK_SIZE, GREEN)
    when 4
      draw_quad(x, y, RED, x + BLOCK_SIZE, y, RED, x, y + BLOCK_SIZE, RED, x + BLOCK_SIZE, y + BLOCK_SIZE, RED)
    when 5
      draw_quad(x, y, GRAY, x + BLOCK_SIZE, y, GRAY, x, y + BLOCK_SIZE, GRAY, x + BLOCK_SIZE, y + BLOCK_SIZE, GRAY)
    when 6
      draw_quad(x, y, WHITE, x + BLOCK_SIZE, y, WHITE, x, y + BLOCK_SIZE, WHITE, x + BLOCK_SIZE, y + BLOCK_SIZE, WHITE)
    when 7
      draw_quad(x, y, BLACK, x + BLOCK_SIZE, y, BLACK, x, y + BLOCK_SIZE, BLACK, x + BLOCK_SIZE, y + BLOCK_SIZE, BLACK)
    end
  end

  def place_current_shape_on_board
    @current_shape.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell != 0
          @board[@current_shape_row + row_index][@current_shape_column + column_index] = cell
        end
      end
    end
  end

  def remove_completed_rows
    full_rows = @board.each_index.select { |i| @board[i].all? { |cell| cell != 0 } }
    full_rows.each do |i|
      @board.delete_at(i)
      @board.unshift(Array.new(COLUMNS, 0))
    end
    @score += full_rows.length
  end

  def board_collision(column_offset = 0, row_offset = 0, shape = @current_shape)
    shape.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        if cell != 0
          row_position = @current_shape_row + row_index + row_offset
          column_position = @current_shape_column + column_index + column_offset
          if row_position >= ROWS || column_position < 0 || column_position >= COLUMNS || @board[row_position][column_position] != 0
            return true
          end
        end
      end
    end
    false
  end
end

# Game window
class GameWindow < Gosu::Window
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = "Tetris"
    @game = Game.new
  end

  def update
    @game.update
  end

  def draw
    @game.draw
  end

  def button_down(id)
    case id
    when Gosu::KbLeft
      @game.move_left
    when Gosu::KbRight
      @game.move_right
    when Gosu::KbUp
      @game.rotate
    when Gosu::KbEscape
      close
    end


Trying to complete 
require 'gosu'

# Constants
BLOCK_SIZE = 30
ROWS = 20
COLUMNS = 10
WINDOW_WIDTH = COLUMNS * BLOCK_SIZE
WINDOW_HEIGHT = (ROWS + 1) * BLOCK_SIZE

# Colors
BLACK = Gosu::Color.new(0xff000000)
WHITE = Gosu::Color.new(0xffffffff)
GRAY = Gosu::Color.new(0xff808080)
RED = Gosu::Color.new(0xffff0000)
GREEN = Gosu::Color.new(0xff00ff00)
BLUE = Gosu::Color.new(0xff0000ff)
YELLOW = Gosu::Color.new(0xffffff00)

# Game logic
class Game
  def initialize
    @board = Array.new(ROWS) { Array.new(COLUMNS, 0) }
    @score = 0
    @current_shape = generate_new_shape
    @current_shape_row = 0
    @current_shape_column = (COLUMNS / 2) - 2
    @ticks = 0
    @game_over = false
  end

  def update
    if @game_over
      return
    end

    @ticks += 1
    if @ticks % 60 == 0
      move_down
    end
  end

  def draw
    draw_board
    draw_current_shape
    draw_score
    if @game_over
      draw_game_over_message
    end
  end

  def move_left
    if !board_collision(-1)
      @current_shape_column -= 1
    end
  end

  def move_right
    if !board_collision(1)
      @current_shape_column += 1
    end
  end

  def move_down
    if !board_collision(0, 1)
      @current_shape_row += 1
    else
      place_current_shape_on_board
      remove_completed_rows
      if board_collision(0, 0, generate_new_shape)
        @game_over = true
      else
        @current_shape = generate_new_shape
        @current_shape_row = 0
        @current_shape_column = (COLUMNS / 2) - 2
      end
    end
  end

  def rotate
    rotated_shape = @current_shape.transpose.map(&:reverse)
    if !board_collision(0, 0, rotated_shape)
      @current_shape = rotated_shape
    end
  end

  private

  def generate_new_shape
    shapes = [
      [
        [1, 1, 0],
        [0, 1, 1],
        [0, 0, 0]
      ],
      [
        [2, 2],
        [2, 2]
      ],
      [
        [0, 3, 0],
        [3, 3, 3],
        [0, 0, 0]
      ],
      [
        [4, 0, 0],
        [4, 4, 4],
        [0, 0, 0]
      ],
      [
        [0, 0, 5],
        [5, 5, 5],
        [0, 0, 0]
      ],
      [
        [0, 6, 6],
        [6, 6, 0],
        [0, 0, 0]
      ],
      [
        [7, 7,





require 'gosu'

# Constants
BLOCK_SIZE = 30
ROWS = 20
COLUMNS = 10
WINDOW_WIDTH = COLUMNS * BLOCK_SIZE
WINDOW_HEIGHT = (ROWS + 1) * BLOCK_SIZE

# Colors
BLACK = Gosu::Color.new(0xff000000)
WHITE = Gosu::Color.new(0xffffffff)
GRAY = Gosu::Color.new(0xff808080)
RED = Gosu::Color.new(0xffff0000)
GREEN = Gosu::Color.new(0xff00ff00)
BLUE = Gosu::Color.new(0xff0000ff)
YELLOW = Gosu::Color.new(0xffffff00)

# Game logic
class Game
  def initialize
    @board = Array.new(ROWS) { Array.new(COLUMNS, 0) }
    @score = 0
    @current_shape = generate_new_shape
    @current_shape_row = 0
    @current_shape_column = (COLUMNS / 2) - 2
    @ticks = 0
    @game_over = false
  end

  def update
    if @game_over
      return
    end

    @ticks += 1
    if @ticks % 60 == 0
      move_down
    end
  end

  def draw
    draw_board
    draw_current_shape
    draw_score
    if @game_over
      draw_game_over_message
    end
  end

  def move_left
    if !board_collision(-1)
      @current_shape_column -= 1
    end
  end

  def move_right
    if !board_collision(1)
      @current_shape_column += 1
    end
  end

  def move_down
    if !board_collision(0, 1)
      @current_shape_row += 1
    else
      place_current_shape_on_board
      remove_completed_rows
      if board_collision(0, 0, generate_new_shape)
        @game_over = true
      else
        @current_shape = generate_new_shape
        @current_shape_row = 0
        @current_shape_column = (COLUMNS / 2) - 2
      end
    end
  end

  def rotate
    rotated_shape = @current_shape.transpose.map(&:reverse)
    if !board_collision(0, 0, rotated_shape)
      @current_shape = rotated_shape
    end
  end

  private

  def generate_new_shape
    shapes = [
      [
        [1, 1, 0],
        [0, 1, 1],
        [0, 0, 0]
      ],
      [
        [2, 2],
        [2, 2]
      ],
      [
        [0, 3, 0],
        [3, 3, 3],
        [0, 0, 0]
      ],
      [
        [4, 0, 0],
        [4, 4, 4],
        [0, 0, 0]
      ],
      [
        [0, 0, 5],
        [5, 5, 5],
        [0, 0, 0]
      ],
      [
        [0, 6, 6],
        [6, 6, 0],
        [0, 0, 0]
      ],
      [
        [7, 7, 0],
        [0, 7, 7],
