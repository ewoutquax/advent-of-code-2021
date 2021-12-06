module Puzzle
  class << self
    def number_of_fish_after_days(days, input = nil)
      school = School.new(input || read_file())

      days.times { |day| school.pass_day }

      school.grouped.values.sum
    end

    private

    def read_file
      File.read("input.txt").split(",").map(&:to_i)
    end
  end
end
