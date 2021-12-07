require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @horizontals = [
      16, 1, 2, 0, 4, 2, 7, 1, 2, 14,
    ]
  end

  context "part 1" do
    it "solve example" do
      fuel = Puzzle.min_fuel_needed_to_move_to_optimal(@horizontals)

      expect(fuel).to eq(37)
    end

    it "solve puzzle" do
      fuel = Puzzle.min_fuel_needed_to_move_to_optimal()

      expect(fuel).to eq(339321)
    end
  end

  context "part 2" do
    it "solve example" do
      fuel = Puzzle.min_fuel_needed_to_move_to_optimal(@horizontals, true)

      expect(fuel).to eq(168)
    end

    it "solve puzzle" do
      fuel = Puzzle.min_fuel_needed_to_move_to_optimal(nil, true)

      expect(fuel).to eq(95476244)
    end
  end
end
