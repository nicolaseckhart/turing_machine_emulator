require './state_machine'
require './state'
require './rule'
require './memory_tape'

# TODO: FIX TAPE OUTPUT WHEN MULTIPLICAND OR MULTIPLIER ARE 0
# TODO: EXTRACT AND CLEAN UP THE PRINTING STUFF
# TODO: IMPLEMENT DISTINCT STEP-BY-STEP AND ALL-IN-ONE MODES
# TODO: ADD SOME MORE EXPLAINING COMMENTS AND A README.md
# TODO: SPEED IT UP?

class Emulator
  def initialize(multiplicand, multiplier)
    @memory_tape = MemoryTape.new(multiplicand.to_i, multiplier.to_i)
    @state_machine = StateMachine.new
    @status = :working

    while @status == :working
      @memory_tape.print_tape
      print_status
      @status = next_step
    end
    case @status
    when :success
      puts "The result is: #{@memory_tape.result}"
    when :failure
      puts 'Something went wrong...'
    end
  end

  def next_step
    # rule that will be applied
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

    # change state in state machine
    @state_machine.current_state = @state_machine.find_state(rule.target_state)

    # move machine head
    head_direction = rule.direction == :left ? -1 : 1
    current_cell_index = @memory_tape.cells.index(@memory_tape.current_cell)
    next_cell_index = current_cell_index + head_direction
    @memory_tape.current_cell = @memory_tape.cells[next_cell_index]

    # write value into previous cell
    @memory_tape.cells[current_cell_index].value = rule.write

    # return working status
    :working
  end

  # gets the next rule that will be applied
  def next_rule
    @state_machine.current_state.find_rule(@memory_tape.current_cell.value)
  end

  def print_status
    puts "\nCURRENT STATE: #{@state_machine.current_state.identifier}"
    puts "CURRENT CELL VALUE: #{@memory_tape.current_cell.value}"
    puts '---------------------'
    puts 'NEXT RULE:'
    puts next_rule.to_s
    puts '---------------------'
  end
end

# execute from console
if ARGV.size == 2
  Emulator.new(ARGV[0], ARGV[1])
else
  puts 'Wrong number of arguments.'
  puts 'Correct usage: ruby emulator.rb MULTIPLICAND MULTIPLIER'
end