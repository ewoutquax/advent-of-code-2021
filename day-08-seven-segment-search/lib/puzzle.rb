module Puzzle
  class << self
    def count_identifiable_digits_after_pipe(lines = nil)
      lines ||= read_file()

      lines.map do |line|
        count_identifiable_digits_after_pipe_per_line(line)
      end.sum
    end

    def sum_deducted_hashes(lines = nil)
      lines ||= read_file()

      lines.map do |line|
        (digit = Digit.new).deduct_letter_locations(line)

        hash_combinations = line.split(" | ").last.split(" ")
        hash_combinations.map { |combination| digit.convert_combination(combination) }.join.to_i
      end.sum
    end

    def deduct_hash_value(line)
      (digit = Digit.new).deduct_letter_locations(line)
      hash_combinations = line.split(" | ").last.split(" ")
      hash_combinations.map do |combination|
        digit.convert_combination(combination)
      end
    end

    private

    def count_identifiable_digits_after_pipe_per_line(line)
      digits_after_pipe = line.split("| ").last.split(" ")
      digits_after_pipe.select do |digit|
        [2, 3, 4, 7].include?(digit.length)
      end.count
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
