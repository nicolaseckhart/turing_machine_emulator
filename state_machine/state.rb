require_relative 'rule'

class State
  attr_accessor :identifier, :accepting, :rules

  # identifier (string) is a parameters unique id. eg: q0, q1, etc.
  # accepting (boolean) marks whether or not a state is an accepting state
  # rules is an array of rule class objects
  def initialize(identifier, accepting, rules)
    @identifier = identifier
    @accepting = accepting
    @rules = rules
  end

  # searchers all rules of this state for one with matching read/input character
  # returns nil if no rule was found
  def find_rule(input)
    result = nil
    @rules.each do |rule|
      result = rule if rule.input == input
    end
    result
  end

  # returns a string summarizing the object
  def to_s
    summary = "STATE: #{@identifier}\n"
    summary += "ACCEPTING STATE: #{@accepting}"
    summary += "RULES COUNT: #{@rules.count}"
  end
end