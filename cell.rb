class Cell
  attr_accessor :value

  # value (any type) is the value held by the cell on the memory tape
  def initialize(value)
    @value = value
  end
end