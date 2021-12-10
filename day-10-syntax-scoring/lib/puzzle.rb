module Puzzle
  class << self
    def get_parser_score(lines = nil)
      lines ||= read_file()

      lines.map do |line|
        result = Parser.line(line)

        case result
        when [:corrupt, ")"]
          3
        when [:corrupt, "]"]
          57
        when [:corrupt, "}"]
          1197
        when [:corrupt, ">"]
          25137
        else
          0
        end
      end.sum
    end

    def get_parser_score_for_incomplete_lines(lines = nil)
      lines ||= read_file()

      scores =
        lines.map do |line|
          result = Parser.line(line)

          case result[0]
          when :incomplete
            Parser.score_for_autocompletion(result[1])
          else
            nil
          end
        end.compact

      center = (scores.length - 1) / 2
      scores.sort[center]
    end

    private

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
