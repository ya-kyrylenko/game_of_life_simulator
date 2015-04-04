require 'gosu'
require_relative 'life-simulator.rb'

class GameWindow < Gosu::Window
  attr_accessor :count
  def initialize(height=1200, width=900)
    @height = height
    @width = width
    super(height, width, false)


    @background = Gosu::Color.new(0xffbbf6e2)
    @alive_color = Gosu::Color.new(0xff42e5ae)
    @dead_color = Gosu::Color.new(0xffffffff)

    @columns = width/15
    @rows = height/15
    @column_w = width/@columns
    @row_h = height/@rows
    @universe = Universe.new(@columns, @rows)
    @game = LogicGame.new(@universe)
    @game.universe.randomly_recovery
    # self.caption = "Game of life     (¬_¬) life cycles: #{@game.cycles} ^~^ press R to restart the Universe ツ"
  end

  def update
    @game.step!
    self.caption = "Game of life     (¬_¬) life cycles: #{@game.cycles} ^~^ press R to restart the Universe ツ"
  end

  def draw
    draw_quad(0, 0, @background,
              width, 0, @background,
              width, height, @background,
              0, height, @background)
    @game.universe.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @column_w, cell.y * @row_h, @alive_color,
                  (cell.x + 1) * @column_w - 2, cell.y * @row_h, @alive_color,
                  (cell.x + 1) * @column_w - 2, (cell.y + 1) * @row_h - 2, @alive_color,
                  cell.x * @column_w, (cell.y + 1) * @row_h - 2, @alive_color)
      else
        draw_quad(cell.x * @column_w, cell.y * @row_h, @dead_color,
                  (cell.x + 1) * @column_w - 2, cell.y * @row_h, @dead_color,
                  (cell.x + 1) * @column_w, (cell.y + 1) * @row_h - 2, @dead_color,
                  cell.x * @column_w, (cell.y + 1) * @row_h - 2, @dead_color)
      end
    end
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case
    when id == Gosu::KbEscape
      close
    when id == Gosu::KbR
      @game.universe.randomly_recovery
      @game.cycles = 0
    end
  end

end

window = GameWindow.new
window.show