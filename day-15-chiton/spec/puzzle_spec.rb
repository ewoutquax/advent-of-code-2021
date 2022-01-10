require "rspec"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @lines = [
      "1163751742",
      "1381373672",
      "2136511328",
      "3694931569",
      "7463417111",
      "1319128137",
      "1359912421",
      "3125421639",
      "1293138521",
      "2311944581",
    ]
  end

  context "samples" do
  end

  context "part 1" do
    it "solve example" do
      risk = Puzzle.lowest_risk(@lines)
      expect(risk).to eq(40)
    end

    it "solve puzzle" do
      risk = Puzzle.lowest_risk()
      expect(risk).to eq(40)
    end
  end

  context "part 2" do
    it "solve example" do
      risk = Puzzle.lowest_risk(@lines)
      expect(risk).to eq(315)
    end

    it "solve puzzle" do
      risk = Puzzle.lowest_risk()
      expect(risk).to eq(2821)
    end
  end
end
