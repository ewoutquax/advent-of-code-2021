module Puzzle
  class << self
    def min_fuel_needed_to_move_to_optimal(horizontals = nil, incremental = false)
      horizontals ||= read_file()

      ((horizontals.min)..(horizontals.max)).inject(nil) do |acc, goal|
        needed = fuel_needed_to_move_to_optimal(horizontals.dup, goal, incremental)

        (acc.nil? || needed < acc) ? needed : acc
      end
    end

    private

    def fuel_needed_to_move_to_optimal(horizontals, goal, incremental)
      horizontals == [] and return 0

      if incremental
        steps = (goal - horizontals.pop).abs
        (((1.0 + steps) / 2) * steps).round
      else
        (goal - horizontals.pop).abs
      end + fuel_needed_to_move_to_optimal(horizontals, goal, incremental)
    end

    def read_file
      File.read("input.txt").split(",").map(&:to_i)
    end
  end
end
