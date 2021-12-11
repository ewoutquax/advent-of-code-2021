require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @lines = [
      "5483143223",
      "2745854711",
      "5264556173",
      "6141336146",
      "6357385478",
      "4167524645",
      "2176841721",
      "6882881134",
      "4846848554",
      "5283751526",
    ]
  end

  context "part 1" do
    it "solve example" do
      count = Puzzle.count_flashes_after_steps(10, @lines)
      expect(count).to eq(204)

      count = Puzzle.count_flashes_after_steps(100, @lines)
      expect(count).to eq(1656)
    end

    it "solve puzzle" do
      count = Puzzle.count_flashes_after_steps(100)
      expect(count).to eq(1562)
    end
  end

  context "part 2" do
    it "solve example" do
      step = Puzzle.find_step_when_all_flash(@lines)
      expect(step).to eq(195)
    end

    it "solve puzzle" do
      step = Puzzle.find_step_when_all_flash()
      expect(step).to eq(268)
    end
  end
end
