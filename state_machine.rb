require './state'
require './rule'

class StateMachine
  attr_accessor :states, :current_state

  # states (array of state objects) are all the states in the state machine. the first state object
  # is automatically the starting state
  def initialize
    @states = [
        State.new(:q0, false, [
            Rule.new(Cell::ELEMENT_VALUE, Cell::BLANK_VALUE, :right, :q1),
            Rule.new(Cell::DELIMITER_VALUE, Cell::BLANK_VALUE, :right, :q6)
        ]),
        State.new(:q1, false, [
            Rule.new(Cell::ELEMENT_VALUE, Cell::ELEMENT_VALUE, :right, :q1),
            Rule.new(Cell::DELIMITER_VALUE, Cell::DELIMITER_VALUE, :right, :q2)
        ]),
        State.new(:q2, false, [
            Rule.new(Cell::ELEMENT_VALUE, Cell::PLACEHOLDER_VALUE, :right, :q3),
            Rule.new(Cell::DELIMITER_VALUE, Cell::DELIMITER_VALUE, :left, :q5)
        ]),
        State.new(:q3, false, [
            Rule.new(Cell::DELIMITER_VALUE, Cell::DELIMITER_VALUE, :right, :q3),
            Rule.new(Cell::ELEMENT_VALUE, Cell::ELEMENT_VALUE, :right, :q3),
            Rule.new(Cell::BLANK_VALUE, Cell::ELEMENT_VALUE, :left, :q4)
        ]),
        State.new(:q4, false, [
            Rule.new(Cell::ELEMENT_VALUE, Cell::ELEMENT_VALUE, :left, :q4),
            Rule.new(Cell::DELIMITER_VALUE, Cell::DELIMITER_VALUE, :left, :q4),
            Rule.new(Cell::PLACEHOLDER_VALUE, Cell::PLACEHOLDER_VALUE, :right, :q2)
        ]),
        State.new(:q5, false, [
            Rule.new(Cell::PLACEHOLDER_VALUE, Cell::ELEMENT_VALUE, :left, :q5),
            Rule.new(Cell::DELIMITER_VALUE, Cell::DELIMITER_VALUE, :left, :q5),
            Rule.new(Cell::ELEMENT_VALUE, Cell::ELEMENT_VALUE, :left, :q5),
            Rule.new(Cell::BLANK_VALUE, Cell::BLANK_VALUE, :right, :q0)
        ]),
        State.new(:q6, false, [
            Rule.new(Cell::ELEMENT_VALUE, Cell::BLANK_VALUE, :right, :q6),
            Rule.new(Cell::DELIMITER_VALUE, Cell::BLANK_VALUE, :right, :q7)
        ]),
        State.new(:q7, true, [])
    ]
    @current_state = @states.first
  end

  # finds a state in this state machine by its unique identifier
  def find_state(identifier)
    @states.each do |state|
      return state if state.identifier == identifier
    end
  end

  # updates the current_state based on a given rules definitions
  def update_current_state(rule)
    @current_state = find_state(rule.target_state)
  end
end