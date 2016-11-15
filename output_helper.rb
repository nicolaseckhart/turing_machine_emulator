module OutputHelper
  def print_init_message(multiplicand, multiplier)
    puts "\nTOURING MACHINE EMULATOR STARTED WITH MULTIPLICAND: #{multiplicand} AND MULTIPLIER #{multiplier}!\n\n"
  end

  def print_failure_message
    puts "\nSOMETHING WENT WRONG...\n\n"
  end

  def print_success_message(multiplicand, multiplier, result)
    puts "\n CALCULATION SUCCESSFULLY COMPLETED!\n THE RESULT OF #{multiplicand}x#{multiplier} is #{result}\n\n"
  end

  def print_memory_tape(memory_tape)
    puts memory_tape.to_s
  end

  def print_current_status(state_machine, memory_tape, next_rule)
    puts "\nCURRENT STATE: #{state_machine.current_state.identifier}"
    puts "CURRENT CELL VALUE: #{memory_tape.current_cell.value}"
    puts '---------------------'
    puts 'NEXT RULE:'
    puts next_rule.to_s
    puts '---------------------'
  end
end