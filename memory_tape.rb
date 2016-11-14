require './cell'

class MemoryTape
  attr_accessor :cells, :current_cell

  def initialize(multiplicand, multiplier)
    @cells = (1..1000).map { Cell.new('B') }
    insert_input_value(multiplicand, multiplier)
  end

  def print_tape
    print_tape_border
    print_machine_head
    print "\n|"
    @cells[printable_cell_range].each do |cell|
      if cell.value == 'B'
        print ' '
      else
        print cell.value
      end
      print '|'
    end
    print_tape_border
  end

  def result
    @cells.map { |cell| cell if cell.value != 'B' }.compact.count
  end

  private

  def insert_input_value(multiplicand, multiplier)
    starting_position = 499

    multiplicand.times do
      starting_position += 1
      @cells[starting_position] = Cell.new(1)
    end

    starting_position += 1
    @cells[starting_position] = Cell.new(0)

    multiplier.times do
      starting_position += 1
      @cells[starting_position] = Cell.new(1)
    end

    starting_position += 1
    @cells[starting_position] = Cell.new(0)

    @current_cell = @cells[500]
  end

  def printable_cell_range
    range_start = 0
    range_end = @cells.size - 1
    @cells.each_with_index do |cell, index|
      if (cell.value != 'B') && (range_start == 0)
        range_start = index - 15
      elsif (cell.value == 'B') && (@cells[index-1].value != 'B')
        range_end = index + 14
      end
    end
    (range_start..range_end)
  end

  def print_machine_head
    print '|'
    @cells[printable_cell_range].each do |cell|
      if cell == @current_cell
        print '*'
      else
        print ' '
      end
      print '|'
    end
  end

  def print_tape_border
    puts
    (2*@cells[printable_cell_range].count+1).times do
      print '='
    end
    puts
  end
end