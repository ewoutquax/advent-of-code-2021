require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @venture_vectors = [
      "0,9 -> 5,9",
      "8,0 -> 0,8",
      "9,4 -> 3,4",
      "2,2 -> 2,1",
      "7,0 -> 7,4",
      "6,4 -> 2,0",
      "0,9 -> 2,9",
      "3,4 -> 1,4",
      "0,0 -> 8,8",
      "5,5 -> 8,2",
    ]
  end

  context "part 1" do
    it "solve example" do
      count = Puzzle.count_overlapping_venture_locations(@venture_vectors)
      expect(count).to eq(5)
    end

    it "solve puzzle" do
      count = Puzzle.count_overlapping_venture_locations()
      expect(count).to eq(5124)
    end
  end

  context "part 2" do
    it "solve example" do
      count = Puzzle.count_overlapping_venture_locations(@venture_vectors, true)
      expect(count).to eq(12)
    end

    it "solve puzzle" do
      count = Puzzle.count_overlapping_venture_locations(nil, true)
      expect(count).to eq(19771)
    end
  end
end
