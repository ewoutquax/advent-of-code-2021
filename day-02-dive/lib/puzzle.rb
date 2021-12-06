module Puzzle
  class << self
    def location_after_steps(steps = nil, use_aim = false)
      submarine = (use_aim) ? SubmarineWithAim.new : Submarine.new
      (steps || read_file()).each { |step| submarine.execute_step(step) }

      submarine.horizontal * submarine.depth
    end

    private

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
