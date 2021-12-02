module Puzzle
  class << self
    def location_after_steps(steps = nil, use_aim = false)
      steps ||= read_file()

      submarine = Submarine.new(use_aim)
      steps.each { |step| submarine.execute_step(step) }

      submarine.horizontal * submarine.depth
    end

    private

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
