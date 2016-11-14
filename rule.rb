class Rule
  attr_accessor :input, :write, :direction, :target_state

  def initialize(input, write, direction, target_state)
    @input = input
    @write = write
    @direction = direction
    @target_state = target_state
  end

  def to_s
    summary = "INPUT CHAR: #{@input}\n"
    summary += "WRITE CHAR: #{@write}\n"
    summary += "DIRECTION: #{@direction}\n"
    summary += "TARGET STATE: #{@target_state}"
    summary
  end
end