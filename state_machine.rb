require './state'
require './rule'

class StateMachine
  attr_accessor :states, :current_state

  # states (array of state objects) are all the states in the state machine. the first state object
  # is automatically the starting state
  def initialize(states)
    @states = states
    @current_state = @states.first
  end

  # finds a state in this state machine by its unique identifier
  def find_state(identifier)
    @states.each do |state|
      return state if state.identifier == identifier
    end
  end
end