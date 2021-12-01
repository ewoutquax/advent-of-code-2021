require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @report_lines = [
      199,
      200,
      208,
      210,
      200,
      207,
      240,
      269,
      260,
      263,
    ]
  end

  context "samples" do
    it "calculates sliding windows" do
      expected_output =
        [
          607,
          618,
          618,
          617,
          647,
          716,
          769,
          792,
        ]

      windows = Puzzle.send(:calculate_sliding_windows, @report_lines)

      expect(windows).to eq(expected_output)
    end
  end

  context "part 1" do
    it "solve example" do
      count = Puzzle.count_increasements(@report_lines)
      expect(count).to eq(7)
    end

    it "solve puzzle" do
      count = Puzzle.count_increasements()
      expect(count).to eq(1564)
    end
  end

  context "part 2" do
    it "solve example" do
      count = Puzzle.count_increasements_with_sliding_windows(@report_lines)

      expect(count).to eq(5)
    end

    it "solve puzzle" do
      count = Puzzle.count_increasements_with_sliding_windows()

      expect(count).to eq(1611)
    end
  end
end
