module Puzzle
  class << self
    def get_power_consumption(report_lines = nil)
      report_lines ||= read_file()

      get_gamma(report_lines) * get_epsilon(report_lines)
    end

    def get_life_support_rating(report_lines = nil)
      report_lines ||= read_file()

      get_oxygen(report_lines) * get_co2(report_lines)
    end

    def get_gamma(report_lines)
      Binary.to_decimal(
        build_binary_on_most_common_char(report_lines)
      )
    end

    def get_epsilon(report_lines)
      Binary.to_decimal(
        build_binary_on_least_common_char(report_lines)
      )
    end

    def get_oxygen(report_lines)
      Binary.to_decimal(
        filter_binary_on_most_common_char(report_lines)
      )
    end

    def get_co2(report_lines)
      Binary.to_decimal(
        filter_binary_on_least_common_char(report_lines)
      )
    end

    private

    def build_binary_on_most_common_char(report_lines)
      build_binary(report_lines, :most_common_char_on_index)
    end

    def build_binary_on_least_common_char(report_lines)
      build_binary(report_lines, :least_common_char_on_index)
    end

    def filter_binary_on_most_common_char(report_lines)
      filter_binary(report_lines, :most_common_char_on_index)
    end

    def filter_binary_on_least_common_char(report_lines)
      filter_binary(report_lines, :least_common_char_on_index)
    end

    def build_binary(report_lines, selection_method, idx = 0)
      idx == report_lines.first.length and return ""

      send(selection_method, idx, report_lines) +
        build_binary(report_lines, selection_method, idx + 1)
    end

    def filter_binary(remaining_lines, selection_method, idx = 0)
      remaining_lines.size == 1 and return remaining_lines.first

      important_char = send(selection_method, idx, remaining_lines)

      filter_binary(
        remaining_lines.select { |line| line[idx] == important_char },
        selection_method,
        idx + 1
      )
    end

    def least_common_char_on_index(idx, lines)
      (["0", "1"] - [most_common_char_on_index(idx, lines)]).first
    end

    def most_common_char_on_index(idx, lines)
      battle_of_the_binaries(idx, lines.dup) < 0 ? "0" : "1"
    end

    def battle_of_the_binaries(idx, lines)
      lines == [] and return 0

      ((lines.pop[idx] == "0") ? -1 : 1) +
        battle_of_the_binaries(idx, lines)
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
