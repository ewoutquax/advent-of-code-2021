require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @school = [3, 4, 3, 1, 2]
  end

  context "part 1" do
    it "solve example" do
      output = Puzzle.number_of_fish_after_days(18, @school)
      expect(output).to eq(26)

      output = Puzzle.number_of_fish_after_days(80, @school)
      expect(output).to eq(5_934)
    end

    it "solve puzzle" do
      output = Puzzle.number_of_fish_after_days(80)
      expect(output).to eq(372_300)
    end
  end

  context "part 2" do
    it "solve example" do
      output = Puzzle.number_of_fish_after_days(256, @school)
      expect(output).to eq(26_984_457_539)
    end

    it "solve puzzle" do
      output = Puzzle.number_of_fish_after_days(256)
      expect(output).to eq("ewout")
    end
  end
end
