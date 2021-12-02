require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @steps = [
      "forward 5",
      "down 5",
      "forward 8",
      "up 3",
      "down 8",
      "forward 2",
    ]
  end

  context "part 1" do
    it "solve example" do
      location = Puzzle.location_after_steps(@steps)
      expect(location).to eq(150)
    end

    it "solve puzzle" do
      location = Puzzle.location_after_steps()
      expect(location).to eq(1561344)
    end
  end

  context "part 2" do
    it "solve example" do
      location = Puzzle.location_after_steps(@steps, true)
      expect(location).to eq(900)
    end

    it "solve puzzle" do
      location = Puzzle.location_after_steps(nil, true)
      expect(location).to eq(1848454425)
    end
  end
end
