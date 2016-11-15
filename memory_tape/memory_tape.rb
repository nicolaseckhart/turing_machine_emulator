require_relative '../state_machine/rule'
require_relative 'cell'

class MemoryTape
  STARTING_TAPE_SIZE=1000       # (integer) defining the starting size of the memory tape
  DISPLAY_BUFFER_CELLS=15       # (integer) how many empty cells should be displayed around the filled cells

  attr_accessor :cells, :current_cell

  def initialize(multiplicand, multiplier)
    # create STARTING_TAPE_SIZE amount of cells in array all with blank value
    @cells = (1..STARTING_TAPE_SIZE).map { Cell.new(Cell::BLANK_VALUE) }
    insert_input_value(multiplicand, multiplier)
  end

  # returns the result of the multiplication as an integer
  def result
    @cells.map { |cell| cell if cell.value != Cell::BLANK_VALUE }.compact.count
  end

  # moves the head and updates the current_cell
  def move_head(rule)
    direction = rule.direction == :left ? -1 : 1
    current_cell_index = @cells.index(@current_cell)
    @current_cell = @cells[current_cell_index + direction]
  end

  # overwrites the value of a cell at a given index based on a given rule
  def overwrite_cell(index, rule)
    @cells[index].value = rule.write
  end

  # returns a formatted string to display the current tape
  def to_s
    summary = "\n#{tape_border}"
    summary += "\n#{machine_head}"
    summary += "\n|#{cells_to_print.map { |cell| cell.value == Cell::BLANK_VALUE ? ' ' : cell.value }.join('|')}|"
    summary += "\n#{tape_border}\n"
  end

  private

  # writes the input (multiplicand and multiplier) onto the tape and sets the current cell
  def insert_input_value(multiplicand, multiplier)
    starting_position = (STARTING_TAPE_SIZE / 2) - 1

    multiplicand.times do
      starting_position += 1
      @cells[starting_position] = Cell.new(Cell::ELEMENT_VALUE)
    end

    starting_position += 1
    @cells[starting_position] = Cell.new(Cell::DELIMITER_VALUE)

    multiplier.times do
      starting_position += 1
      @cells[starting_position] = Cell.new(Cell::ELEMENT_VALUE)
    end

    starting_position += 1
    @cells[starting_position] = Cell.new(Cell::DELIMITER_VALUE)

    @current_cell = @cells[(STARTING_TAPE_SIZE / 2)]
  end

  # subset of the cells array that contains the cells that need to be displayed
  def cells_to_print
    if only_blank_cells?
      return @cells[(@cells.index(@current_cell)-15..@cells.index(@current_cell)+15)]
    end
    range_start = 0
    range_end = @cells.size - 1
    @cells.each_with_index do |cell, index|
      if (cell.value != Cell::BLANK_VALUE) && (range_start == 0)
        range_start = index - DISPLAY_BUFFER_CELLS
      elsif (cell.value == Cell::BLANK_VALUE) && (@cells[index-1].value != Cell::BLANK_VALUE)
        range_end = index + (DISPLAY_BUFFER_CELLS-1)
      end
    end
    @cells[(range_start..range_end)]
  end

  def only_blank_cells?
    @cells.map { |cell| cell if cell.value == Cell::BLANK_VALUE }.compact.count == @cells.count
  end

  def machine_head
    head = '|'
    cells_to_print.each do |cell|
      head += cell == @current_cell ? '*|' : ' |'
    end
    head
  end

  def tape_border
    (1..(2*cells_to_print.count+1)).map { '=' }.join
  end
end