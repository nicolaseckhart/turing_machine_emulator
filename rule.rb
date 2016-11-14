class Rule
  attr_accessor :input, :write, :direction, :target_state

  # input (any type) is the cell value that is read, for this rule to be executed
  # write (any type) is the value that should be written on the previously read cell
  # direction (symbol) is the direction. :left for left, :right for right
  # target_state (string) is the target state objects identifier
  def initialize(input, write, direction, target_state)
    @input = input
    @write = write
    @direction = direction
    @target_state = target_state
  end

  # returns a string summarizing the object
  def to_s
    summary = "INPUT CHAR: #{@input}\n"
    summary += "WRITE CHAR: #{@write}\n"
    summary += "DIRECTION: #{@direction}\n"
    summary += "TARGET STATE: #{@target_state}"
  end
end