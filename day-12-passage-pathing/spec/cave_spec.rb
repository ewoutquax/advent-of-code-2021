require "rspec"
require "bootstrapper"

RSpec.describe Cave do
  before do
    @lines =
      [
        "start-A",
        "start-b",
        "A-c",
        "A-b",
        "b-d",
        "A-end",
        "b-end",
      ]
  end

  let(:caves) { Cave.parse_caves(@lines) }
  let(:cave) { caves.values.first }

  it "has a name" do
    expect(cave.name).to be_kind_of(String)
  end

  it "can detect the end-cave" do
    cave = Cave.new("end")
    expect(cave.is_end?).to eq(true)

    cave = Cave.new("start")
    expect(cave.is_end?).to eq(false)
  end

  it "can detect small caves" do
    cave = Cave.new("a")

    expect(cave.small?).to eq(true)
  end

  it "can detect big caves" do
    cave = Cave.new("A")

    expect(cave.small?).to eq(false)
  end

  context "parse list" do
    let(:adjecent) { caves["start"].adjecent }

    it "parse the list of caves" do
      expect(caves).to be_kind_of(Hash)
    end

    it "start has adjecent caves" do
      expect(adjecent.size).to eq(2)
    end
  end

  context "return list of reachable caves, in context of a path" do
    it "returns small caves, not visited during path" do
      reachable = caves["start"].reachable_caves([], false)

      expect(reachable.include?(caves["b"])).to eq(true)
    end

    it "ignores small caves, already visited during path" do
      reachable = caves["start"].reachable_caves([caves["b"]], false)

      expect(reachable.include?(caves["b"])).to eq(false)
    end

    it "returns big caves, already visited during path" do
      reachable = caves["start"].reachable_caves([caves["A"]], false)

      expect(reachable.include?(caves["A"])).to eq(true)
    end
  end
end
