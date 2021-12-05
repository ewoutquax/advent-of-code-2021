require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Map do
  let(:map) { Map.new(false) }

  before do
    @vector = "0,9 -> 5,9"
  end

  context "draw rift" do
    it "can mark the locations of a straight horizontal rift" do
      map.draw_rift("0,9 -> 5,9")

      expect(map.locations.size).to eq(6)
    end

    it "can mark the locations of a straight vertical rift" do
      map.draw_rift("7,0 -> 7,4")

      expect(map.locations.size).to eq(5)
    end

    it "can detect an overlap" do
      map.draw_rift("7,0 -> 7,4")
      map.draw_rift("9,4 -> 3,4")

      expect(map.locations.size).to eq(11)
      expect(map.locations[7004]).to eq(2)
    end
  end
end
