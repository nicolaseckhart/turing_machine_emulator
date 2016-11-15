require_relative 'helpers/output_helper'
require_relative 'machine'

include OutputHelper

def clear_screen
  system 'clear'
  print_init_message
end

def request_multiplicand
  clear_screen
  print 'Please enter a positive whole integer or zero (multiplicand): '
  multiplicand = gets.strip.to_i
  puts "-> Multiplicand #{multiplicand} chosen."
  multiplicand
end

def request_multiplier
  clear_screen
  print 'Please enter a positive whole integer or zero (multiplier): '
  multiplier = gets.strip.to_i
  puts "-> Multiplier #{multiplier} chosen."
  multiplier
end

def request_mode
  mode = :invalid
  while mode == :invalid
    clear_screen
    print 'Choose a execution mode (full: calculate everything in one go, step: step-by-step output (default): '
    mode = gets.strip.to_sym
    if mode == :full
      puts '-> The result will be displayed after the calculation has been completed.'
    elsif mode == :step
      puts '-> There will be an output after every calculation step.'
    end
  end
  mode
end

def request_speed
  speed = :invalid
  while speed == :invalid
    clear_screen
    print 'Choose a speed for the steps to be run at (fast, medium, slow): '
    speed = gets.strip.to_sym
    if (speed == :fast) || (speed == :medium) || (speed == :slow)
      puts "-> Speed #{speed} chosen."
    end
  end
  speed
end

multiplicand = request_multiplicand
multiplier = request_multiplier
mode = request_mode

if mode == :step
  speed = request_speed
  Machine.new(multiplicand, multiplier, mode, speed)
else
  Machine.new(multiplicand, multiplier, mode)
end