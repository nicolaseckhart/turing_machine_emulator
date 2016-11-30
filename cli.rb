require_relative 'helpers/output_helper'
require_relative 'machine'

include OutputHelper

def clear_screen
  system 'clear'
  print_init_message
end

def request_input_mode
  input_mode = :invalid
  while input_mode == :invalid
    clear_screen
    print 'Please enter input mode (decimal or unary): '
    input_mode = gets.strip.to_sym
    if input_mode == :decimal || input_mode == :unary
      puts "-> Input mode #{input_mode} chosen."
    else
      input_mode = :invalid
    end
  end
  input_mode
end

def request_unary_input
  clear_screen
  print 'Please enter the multiplicand and multiplier in this format 3x2 = 000100: '
  unary_input = gets.strip.split('1').reject(&:empty?)

  if unary_input.size == 0
    { multiplicand: 0, multiplier: 0 }
  elsif unary_input.size == 1
    { multiplicand: 0, multiplier: unary_input[0].split('').count }
  else
    multiplicand = unary_input[0].split('').count
    puts "-> Multiplicand #{multiplicand} chosen."

    multiplier = unary_input[0].split('').count
    puts "-> Multiplier #{multiplier} chosen."

    { multiplicand: multiplicand, multiplier: multiplier }
  end
end

def request_decimal_input
  clear_screen
  print 'Please enter a positive whole integer or zero (multiplicand): '
  multiplicand = gets.strip.to_i
  puts "-> Multiplicand #{multiplicand} chosen."

  print 'Please enter a positive whole integer or zero (multiplier): '
  multiplier = gets.strip.to_i
  puts "-> Multiplier #{multiplier} chosen."

  { multiplicand: multiplicand, multiplier: multiplier }
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
    else
      mode = :invalid
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
    else
      speed = :invalid
    end
  end
  speed
end

input_mode = request_input_mode
if input_mode == :decimal
  input = request_decimal_input
elsif input_mode == :unary
  input = request_unary_input
end

multiplicand = input[:multiplicand]
multiplier = input[:multiplier]
mode = request_mode

if mode == :step
  speed = request_speed
  Machine.new(multiplicand, multiplier, mode, speed)
else
  Machine.new(multiplicand, multiplier, mode)
end