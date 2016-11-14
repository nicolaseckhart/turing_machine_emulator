require './rule'

class State
  attr_accessor :identifier, :accepting, :rules

  def initialize(identifier, accepting, rules)
    @identifier = identifier
    @accepting = accepting
    @rules = rules
  end

  def find_rule(input)
    result = nil
    @rules.each do |rule|
      result = rule if rule.input == input
    end
    result
  end

  def print_summary
    puts "\n=================="
    puts @identifier
    puts '=================='
    puts 'RULES:'
    puts '------------------'
    @rules.each do |rule|
      puts rule.to_s
      puts '------------------'
    end
    puts "==================\n"
  end
end