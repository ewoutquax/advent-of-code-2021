require "rspec"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @lines = [[
      "6,10",
      "0,14",
      "9,10",
      "0,3",
      "10,4",
      "4,11",
      "6,0",
      "6,12",
      "4,1",
      "0,13",
      "10,12",
      "3,4",
      "3,0",
      "8,4",
      "1,10",
      "2,14",
      "8,10",
      "9,0",
    ], [
      "fold along y=7",
      "fold along x=5",
    ]]
  end

  context "part 1" do
    it "solve example" do
      count = Puzzle.count_unique_dots_after_one_fold(@lines)
      expect(count).to eq(17)
    end

    it "solve puzzle" do
      count = Puzzle.count_unique_dots_after_one_fold()
      expect(count).to eq(653)
    end
  end

  context "part 2" do
    it "solve puzzle" do
      Puzzle.fold_and_draw() # Result: LKREBPRK
    end
  end
end
