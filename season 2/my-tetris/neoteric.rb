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
        [


[0, 0, 0]
]
]
shapes.sample.map(&:clone)
end

def draw_board
@board.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
draw_block(column_index, row_index, color_for_block(cell))
end
end
end

def draw_current_shape
@current_shape.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
if cell != 0
draw_block(
column_index + @current_shape_column,
row_index + @current_shape_row,
color_for_block(cell)
)
end
end
end
end

def draw_score
score_text = "Score: #{@score}"
Gosu.draw_rect(
0,
ROWS * BLOCK_SIZE,
WINDOW_WIDTH,
BLOCK_SIZE,
GRAY,
0
)
Gosu.draw_rect(
0,
ROWS * BLOCK_SIZE,
Gosu::measure_text_width(score_text),
BLOCK_SIZE,
BLACK,
1
)

Gosu.draw_rect(
0,
ROWS * BLOCK_SIZE,
Gosu::measure_text_width(score_text),
BLOCK_SIZE,
BLACK,
1
)
Gosu.draw_rect(
0,
ROWS * BLOCK_SIZE,
Gosu::measure_text_width(score_text),
BLOCK_SIZE,
WHITE,
0
)

Gosu.draw_rect(
0,
ROWS * BLOCK_SIZE,
Gosu::measure_text_width(score_text),
BLOCK_SIZE,
WHITE,
0
)
Gosu.draw_text(
score_text,
0,
ROWS * BLOCK_SIZE,
0,
1,
1,
BLACK
)
end

def draw_game_over_message
message = "Game Over"
Gosu.draw_rect(
0,
(ROWS / 2) * BLOCK_SIZE,
WINDOW_WIDTH,
BLOCK_SIZE,
GRAY,
0
)
Gosu.draw_rect(
0,
(ROWS / 2) * BLOCK_SIZE,
Gosu::measure_text_width(message),
BLOCK_SIZE,
BLACK,
1
)

Gosu.draw_rect(
0,
(ROWS / 2) * BLOCK_SIZE,
Gosu::measure_text_width(message),
BLOCK_SIZE,
WHITE,
0
)
Gosu.draw_text(
message,
(WINDOW_WIDTH - Gosu::measure_text_width(message)) / 2,
(ROWS / 2) * BLOCK_SIZE,
0,
1,
1,
BLACK
)
end

def draw_block(column, row, color)
Gosu.draw_rect(
column * BLOCK_SIZE,
row * BLOCK_SIZE,
BLOCK_SIZE,
BLOCK_SIZE,
color,
1
)
Gosu.draw_rect(
column * BLOCK_SIZE + 1,
row * BLOCK_SIZE + 1,
BLOCK_SIZE - 2,
BLOCK_SIZE - 2,
color,
0
)
end

def draw_block(column, row, color)
Gosu.draw_rect(
column * BLOCK_SIZE,
row * BLOCK_SIZE,
BLOCK_SIZE,
BLOCK_SIZE,
color,
1
)
Gosu.draw_rect(
column * BLOCK_SIZE + 1,
row * BLOCK_SIZE + 1,
BLOCK_SIZE - 2,
BLOCK_SIZE - 2,
color,
0
)
end

def board_collision(column_offset, row_offset, shape = nil)
shape ||= @current_shape
shape.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
if cell != 0
board_row = row_index +


row_offset
board_column = column_index + column_offset
if board_column < 0 || board_column >= COLUMNS ||
board_row >= ROWS || @board[board_row][board_column] != 0
return true
end
end
end
end
false
end

def rotate_shape(shape)
rotated_shape = Array.new(shape[0].size) { Array.new(shape.size, 0) }
shape.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
rotated_shape[column_index][row.size - row_index - 1] = cell
end
end
rotated_shape
end

def remove_complete_rows
complete_rows = @board.each_with_index.select do |row, index|
row.all? { |cell| cell != 0 }
end.map(&:last)

complete_rows.each do |row_index|
  @board.delete_at(row_index)
  @board.unshift(Array.new(COLUMNS, 0))
end

@score += complete_rows.size * 100


end

def button_down(id)
if id == Gosu::KbLeft
move_left
elsif id == Gosu::KbRight
move_right
elsif id == Gosu::KbDown
move_down
elsif id == Gosu::KbUp
rotate
elsif id == Gosu::KbEscape
close
end
end

def move_left
if !board_collision(@current_shape_column - 1, @current_shape_row)
@current_shape_column -= 1
end
end

def move_right
if !board_collision(@current_shape_column + 1, @current_shape_row)
@current_shape_column += 1
end
end


def move_down
if !board_collision(@current_shape_column, @current_shape_row + 1)
@current_shape_row += 1
else
place_current_shape_on_board
remove_complete_rows
if !game_over?
new_shape
end
end
end

def rotate
rotated_shape = rotate_shape(@current_shape)
if !board_collision(@current_shape_column, @current_shape_row, rotated_shape)
@current_shape = rotated_shape
end
end

def place_current_shape_on_board
@current_shape.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
if cell != 0
@board[row_index + @current_shape_row][column_index + @current_shape_column] = cell
end
end
end
end

def game_over?
board_collision(@current_shape_column, @current_shape_row)
end
end

TetrisGame.new.show




require 'gosu'

ROWS = 20
COLUMNS = 10
CELL_SIZE = 30
WINDOW_WIDTH = CELL_SIZE * COLUMNS
WINDOW_HEIGHT = CELL_SIZE * ROWS

SHAPES = [  [    [1, 1, 1],
    [0, 1, 0],
    [0, 0, 0],
  ],
  [    [2, 2],
    [2, 2],
  ],
  [    [0, 3, 3],
    [3, 3, 0],
    [0, 0, 0],
  ],
  [    [4, 4, 0],
    [0, 4, 4],
    [0, 0, 0],
  ],
  [    [0, 5, 0],
    [5, 5, 5],
    [0, 0, 0],
  ],
  [    [6, 6, 6],
    [6, 0, 0],
    [0, 0, 0],
  ],
  [    [7, 7, 7, 7],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ],
]

COLORS = [  Gosu::Color::RED,  Gosu::Color::BLUE,  Gosu::Color::GREEN,  Gosu::Color::YELLOW,  Gosu::Color::FUCHSIA,  Gosu::Color::AQUA,  Gosu::Color::WHITE,]

class TetrisGame < Gosu::Window
  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = "Tetris Game"

    @font = Gosu::Font.new(30)
    @board = Array.new(ROWS) { Array.new(COLUMNS, 0) }

    new_shape
    @score = 0
  end

  def new_shape
    @current_shape = SHAPES.sample.map(&:dup)
    @current_shape_color = COLORS.sample
    @current_shape_column = COLUMNS / 2 - @current_shape[0].size / 2
    @current_shape_row = 0
  end

  def update
    move_down
  end

  def draw
    draw_board
    draw_score
    draw_shape(@current_shape, @current_shape_column, @current_shape_row, @current_shape_color)
  end

  def draw_board
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        draw_cell(column_index, row_index, COLORS[cell]) if cell != 0
      end
    end
  end

  def draw_shape(shape, column, row, color)
    shape.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        draw_cell(column + column_index, row + row_index, color) if cell != 0
      end
    end
  end

  def draw_cell(column, row, color)
    x = column * CELL_SIZE
    y = row * CELL_SIZE
    draw_quad(x, y, color, x + CELL_SIZE, y, color,
              x, y + CELL_SIZE, color, x + CELL


_SIZE, y + CELL_SIZE, color, z_order = 1)
end

def move_down
if can_move?(@current_shape, @current_shape_column, @current_shape_row + 1)
@current_shape_row += 1
else
freeze_current_shape
remove_completed_rows
new_shape
if game_over?
close
puts "Game Over. Score: #{@score}"
end
end
end

def move_left
if can_move?(@current_shape, @current_shape_column - 1, @current_shape_row)
@current_shape_column -= 1
end
end

def move_right
if can_move?(@current_shape, @current_shape_column + 1, @current_shape_row)
@current_shape_column += 1
end
end

def rotate
new_shape = rotate_shape(@current_shape)
if can_move?(new_shape, @current_shape_column, @current_shape_row)
@current_shape = new_shape
end
end

def rotate_shape(shape)
shape.transpose.map(&:reverse)
end

def can_move?(shape, column, row)
shape.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
if cell != 0
target_column = column + column_index
target_row = row + row_index
if target_column < 0 || target_column >= COLUMNS ||
target_row >= ROWS || (@board[target_row][target_column] != 0)
return false
end
end
end
end
true
end


def freeze_current_shape
@current_shape.each_with_index do |row, row_index|
row.each_with_index do |cell, column_index|
if cell != 0
target_column = @current_shape_column + column_index
target_row = @current_shape_row + row_index
@board[target_row][target_column] = @current_shape_color
end
end
end
end

def remove_completed_rows
(0...ROWS).each do |row|
if @board[row].all? { |cell| cell != 0 }
@board.delete_at(row)
@board.unshift(Array.new(COLUMNS, 0))
@score += 10
end
end
end

def game_over?
@board[0].any? { |cell| cell != 0 }
end


def draw_score
@font.draw("Score: #{@score}", 10, 10, 0)
end

def button_down(id)
case id
when Gosu::KbLeft
move_left
when Gosu::KbRight
move_right
when Gosu::KbDown
move_down
when Gosu::KbUp
rotate
when Gosu::KbEscape
close
end
end
end

TetrisGame.new.show if FILE == $PROGRAM_NAME


This code uses the Gosu library to create a window for the game and handle user input. The game logic is implemented in the `TetrisGame` class, which keeps track of the current shape, the board, and the score. It also defines methods for moving the current shape, checking if it can move, freezing it in place, removing completed rows, and checking if the game is over.

The `draw` method is called every frame and is responsible for drawing the board
