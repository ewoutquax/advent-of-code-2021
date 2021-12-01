module Puzzle
  class << self
    def count_increasements_with_sliding_windows(report_lines = nil)
      count_increasements(
        calculate_sliding_windows(report_lines || read_file())
      )
    end

    def count_increasements(report_lines = nil)
      count = 0

      (report_lines || read_file()).inject() do |previous, current|
        current > previous && count += 1

        current
      end

      count
    end

    private

    def calculate_sliding_windows(report_lines)
      window = []
      report_lines.inject([]) do |acc, report|
        window = (window.last(2) << report)
        window.length == 3 && acc << window.sum

        acc
      end
    end

    def read_file
      File.read("input.txt").split("\n").map(&:to_i)
    end
  end
end
