class Emulator
  def initialize(multiplicand, multiplier)
    @multiplicand = multiplicand
    @multiplier = multiplier
    @memory_tape = MemoryTape.new
  end
end