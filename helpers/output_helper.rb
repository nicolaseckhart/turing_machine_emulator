module OutputHelper
  def print_init_message
    puts "\nTOURING MACHINE EMULATOR (multiplication)"
    puts "=========================================\n\n"
  end

  def print_program_header(multiplicand, multiplier)
    system 'clear'
    puts "\nTOURING MACHINE EMULATOR (multiplication)"
    puts "=========================================\n"
    puts "MULTIPLICAND: #{multiplicand}"
    puts "MULTIPLIER: #{multiplier}\n"
  end

  def print_failure_message
    puts "\nSOMETHING WENT WRONG...\n\n"
  end

  def print_success_message(multiplicand, multiplier, result, step_counter, duration)
    puts "\nTHE RESULT OF #{multiplicand}x#{multiplier} is #{result}\n"\
         "NUMBER CALCULATIONS: #{step_counter} (TOOK #{duration} SECONDS TO RUN).\n\n"
  end

  def print_memory_tape(memory_tape)
    puts memory_tape.to_s
  end

  def print_current_status(state_machine, memory_tape, next_rule)
    puts "CURRENT STATE: #{state_machine.current_state.identifier}"
  end
end