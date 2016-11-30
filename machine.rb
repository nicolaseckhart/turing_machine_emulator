require_relative 'helpers/output_helper'
require_relative 'state_machine/state_machine'
require_relative 'state_machine/state'
require_relative 'state_machine/rule'
require_relative 'memory_tape/memory_tape'

class Machine
  include OutputHelper

  attr_accessor :memory_tape, :state_machine, :status, :step_counter, :multiplicand, :multiplier

  # memory_tape (memory_tape object) is the turing machines tape, instantiated once with two positive integers
  # state_machine (state_machine object) is the turing machines state machine, instantiated once without params
  # status (symbol) is the current status of the machine: :working means calculations in progress, :failure means
  # that something went wrong, :success means that the result has been calculated
  def initialize(multiplicand, multiplier, mode, speed=nil)
    @multiplicand = multiplicand
    @multiplier = multiplier

    @memory_tape = MemoryTape.new(multiplicand, multiplier)
    @state_machine = StateMachine.new
    @status = :working
    @step_counter = 0

    start_time = Time.now
    if mode == :full
      start_full
    elsif mode == :step
      start_step(speed)
    end
    finish(Time.now - start_time)
  end

  private

  # executes on step of the machine (check if success / failure, read input, write char, change state and move head)
  def next_step
    current_cell_index = @memory_tape.cells.index(@memory_tape.current_cell)
    rule = next_rule

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

  # while the status is :working, the machine continuously applies the next rule based on the current read char
  # outputs a summary after all calculations have been run
  def start_full
    print_program_header(@multiplicand, @multiplier)
    print_memory_tape(@memory_tape)
    print_current_status(@state_machine, @memory_tape, next_step)
    while @status == :working
      @status = next_step
      @step_counter += 1
    end
    print_memory_tape(@memory_tape)
    print_current_status(@state_machine, @memory_tape, next_rule)
  end

  # while the status is :working, the machine continuously applies the next rule based on the current read char
  # outputs a summary during each step of the calculation
  def start_step(speed)
    while @status == :working
      sleep calculate_speed(speed)
      print_program_header(@multiplicand, @multiplier)
      print_memory_tape(@memory_tape)
      print_current_status(@state_machine, @memory_tape, next_rule)
      @status = next_step
      @step_counter += 1
    end
  end

  # once the status is no longer :working, this method prints out a message for :success or :failure
  def finish(duration)
    if @status == :success
      print_success_message(@multiplicand, @multiplier, @memory_tape.result, @step_counter, duration)
    elsif @status == :failure
      print_failure_message
    end
  end

  # returns the number of seconds set by speed
  def calculate_speed(speed)
    case speed
      when :fast
        0
      when :slow
        0.75
      else
        0.25
    end
  end
end