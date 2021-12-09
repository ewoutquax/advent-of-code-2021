require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @lines = [
      "2199943210",
      "3987894921",
      "9856789892",
      "8767896789",
      "9899965678",
    ]
  end

  context "part 1" do
    it "solve example" do
      risk = Puzzle.sum_risk_of_low_points(@lines)
      expect(risk).to eq(15)
    end

    it "solve puzzle" do
      risk = Puzzle.sum_risk_of_low_points()
      expect(risk).to eq(526)
    end
  end

  context "part 2" do
    it "solve example" do
      product = Puzzle.product_of_three_largest_basins(@lines)
      expect(product).to eq(1134)
    end

    it "solve puzzle" do
      product = Puzzle.product_of_three_largest_basins()
      expect(product).to eq(1123524)
    end
  end
end
