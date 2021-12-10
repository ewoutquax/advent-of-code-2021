require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @lines = [
      "{([(<{}[<>[]}>{[]{[(<()>",
      "[[<[([]))<([[{}[[()]]]",
      "[{[{({}]{}}([{[{{{}}([]",
      "[<(<(<(<{}))><([]([]()",
      "<{([([[(<>()){}]>(<<{{",
    ]

    @incomplete_lines = [
      "[({(<(())[]>[[{[]{<()<>>",
      "[(()[<>])]({[<{<<[]>>(",
      "(((({<>}<{<{<>}{[]{[]{}",
      "{<[[]]>}<{[{[{[]{()[[[]",
      "<{([{{}}[<[[[<>{}]]]>[]]",
    ]
  end

  context "part 1" do
    it "solve example" do
      score = Puzzle.get_parser_score(@lines)
      expect(score).to eq(26397)
    end

    it "solve puzzle" do
      score = Puzzle.get_parser_score()
      expect(score).to eq(311895)
    end
  end

  context "part 2" do
    it "solve example" do
      score = Puzzle.get_parser_score_for_incomplete_lines(@incomplete_lines)
      expect(score).to eq(288957)
    end

    it "solve puzzle" do
      score = Puzzle.get_parser_score_for_incomplete_lines()
      expect(score).to eq(2904180541)
    end
  end
end
