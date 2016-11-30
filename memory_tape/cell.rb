class Cell
  ELEMENT_VALUE=0
  DELIMITER_VALUE=1
  PLACEHOLDER_VALUE=:X
  BLANK_VALUE=:B

  attr_accessor :value

  # value (any type) is the value held by the cell on the memory tape
  def initialize(value)
    @value = value
  end
end