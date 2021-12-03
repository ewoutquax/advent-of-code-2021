require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @report_lines = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010",
    ]
  end

  context "samples" do
    it "can get the gamma" do
      gamma = Puzzle.get_gamma(@report_lines)
      expect(gamma).to eq(22)
    end
    it "can get the epsilon" do
      gamma = Puzzle.get_epsilon(@report_lines)
      expect(gamma).to eq(9)
    end

    it "can get the oxygen" do
      oxygen = Puzzle.get_oxygen(@report_lines)
      expect(oxygen).to eq(23)
    end

    it "can get the co2" do
      co2 = Puzzle.get_co2(@report_lines)
      expect(co2).to eq(10)
    end
  end

  context "part 1" do
    it "solve example" do
      consumption = Puzzle.get_power_consumption(@report_lines)

      expect(consumption).to eq(198)
    end

    it "solve puzzle" do
      consumption = Puzzle.get_power_consumption()

      expect(consumption).to eq(3320834)
    end
  end

  context "part 2" do
    it "solve example" do
      rating = Puzzle.get_life_support_rating(@report_lines)

      expect(rating).to eq(230)
    end

    it "solve puzzle" do
      rating = Puzzle.get_life_support_rating()

      expect(rating).to eq(4481199)
    end
  end
end
