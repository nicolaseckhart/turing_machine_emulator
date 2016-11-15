require './state_machine'
require './state'
require './rule'
require './memory_tape'
require './output_helper'

# TODO: IMPLEMENT ALL-IN-ONE MODE

class Machine
  include OutputHelper

  attr_accessor :memory_tape, :state_machine, :status, :step_counter

  # memory_tape (memory_tape object) is the turing machines tape, instantiated once with two positive integers
  # state_machine (state_machine object) is the turing machines state machine, instantiated once without params
  # status (symbol) is the current status of the machine: :working means calculations in progress, :failure means
  # that something went wrong, :success means that the result has been calculated
  def initialize(multiplicand, multiplier)
    @memory_tape = MemoryTape.new(multiplicand.to_i, multiplier.to_i)
    @state_machine = StateMachine.new
    @status = :working
    @step_counter = 0

    start
    finish(multiplicand, multiplier)
  end

  private

  # while the status is :working, the machine continuously applies the next rule based on the current read char
  def start
    while @status == :working
      print_memory_tape(@memory_tape)
      print_current_status(@state_machine, @memory_tape, next_rule)
      @status = next_step
      @step_counter += 1
    end
  end

  # once the status is no longer :working, this method prints out a message for :success or :failure
  def finish(multiplicand, multiplier)
    if @status == :success
      print_success_message(multiplicand, multiplier, @memory_tape.result, @step_counter)
    elsif @status == :failure
      print_failure_message
    end
  end

  # executes on step of the machine (check if success / failure, read input, write char, change state and move head)
  def next_step
    rule = next_rule
    current_cell_index = @memory_tape.cells.index(@memory_tape.current_cell)

    if rule.nil?
      if @state_machine.current_state.accepting
        # return status success if in accepting state and no further movement possible
        return :success
      else
        # return status failure if not in accepting state and no further movement possible
        return :failure
      end
    end

    @state_machine.update_current_state(rule)
    @memory_tape.move_head(rule)
    @memory_tape.overwrite_cell(current_cell_index, rule)

    :working
  end

  # gets the next rule that will be applied
  def next_rule
    @state_machine.current_state.find_rule(@memory_tape.current_cell.value)
  end
end

# execute from console
if ARGV.size == 2
  Machine.new(ARGV[0], ARGV[1])
else
  puts 'Wrong number of arguments.'
  puts 'Correct usage: ruby machine.rb MULTIPLICAND MULTIPLIER'
end