module Puzzle
  class << self
    def number_of_fish_after_days(days, input = nil)
      fishes = (input || read_file())
      school = School.new(fishes)

      days.times do |day|
        school.pass_day
      end

      school.grouped.values.sum
    end

    private

    def read_file
      File.read("input.txt").split(",").map(&:to_i)
    end
  end
end
