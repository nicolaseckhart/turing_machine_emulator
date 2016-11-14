require './state'
require './rule'

class StateMachine
  attr_accessor :states, :current_state

  # 1 = element, 0 = delimiter, 'X' = placeholder, 'B' = blank cell
  def initialize
    @states = [
        State.new(:q0, false, [
            Rule.new(1, 'B', :right, :q1),
            Rule.new(0, 'B', :right, :q6)
        ]),
        State.new(:q1, false, [
            Rule.new(1, 1, :right, :q1),
            Rule.new(0, 0, :right, :q2)
        ]),
        State.new(:q2, false, [
            Rule.new(1, 'X', :right, :q3),
            Rule.new(0, 0, :left, :q5)
        ]),
        State.new(:q3, false, [
            Rule.new(0, 0, :right, :q3),
            Rule.new(1, 1, :right, :q3),
            Rule.new('B', 1, :left, :q4)
        ]),
        State.new(:q4, false, [
            Rule.new(1, 1, :left, :q4),
            Rule.new(0, 0, :left, :q4),
            Rule.new('X', 'X', :right, :q2)
        ]),
        State.new(:q5, false, [
            Rule.new('X', 1, :left, :q5),
            Rule.new(0, 0, :left, :q5),
            Rule.new(1, 1, :left, :q5),
            Rule.new('B', 'B', :right, :q0)
        ]),
        State.new(:q6, false, [
            Rule.new(1, 'B', :right, :q6),
            Rule.new(0, 'B', :right, :q7)
        ]),
        State.new(:q7, true, [])
    ]
    @current_state = @states.first
  end

  def find_state(identifier)
    @states.each do |state|
      return state if state.identifier == identifier
    end
  end
end