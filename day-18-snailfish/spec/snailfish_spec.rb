require "rspec"
require "bootstrapper"

RSpec.describe Snailfish do
  context "parse [1,2]" do
    let(:legends) { Snailfish.new("[1,2]").legends }

    it "creates an entry for each number" do
      expect(legends.length).to eq(2)
    end

    it "keeps track of the depth" do
      expect(legends[0].depth).to eq(1)
      expect(legends[1].depth).to eq(1)
    end

    it "keeps track of the values" do
      expect(legends[0].value).to eq(1)
      expect(legends[1].value).to eq(2)
    end

    it "keeps track of the locations" do
      expect(legends[0].start_position).to eq(1)
      expect(legends[1].start_position).to eq(3)
    end
  end

  context "parse [[[9,[3,8]],[[0,9],6]],[[[3,7],[4,9]],3]]" do
    let(:legends) { Snailfish.new("[[[9,[3,8]],[[0,9],6]],[[[3,7],[4,9]],3]]").legends }

    it "creates an entry for each number" do
      expect(legends.length).to eq(11)
    end

    it "keeps track of the depth" do
      expect(legends.map(&:depth)).to eq([3, 4, 4, 4, 4, 3, 4, 4, 4, 4, 2])
    end

    it "keeps track of the values" do
      expect(legends.map(&:value)).to eq([9, 3, 8, 0, 9, 6, 3, 7, 4, 9, 3])
    end

    it "keeps track of the locations" do
      expect(legends.map(&:start_position)).to eq([3, 6, 8, 14, 16, 19, 26, 28, 32, 34, 38])
    end

    it "keeps track of pairs" do
      expect(legends.map(&:in_pair?)).to eq([false, true, true, true, true, false, true, true, true, true, false])
    end
  end

  context "parse double digit numbers" do
    let(:legends) { Snailfish.new("[[[[0,7],4],[15,[0,13]]],[1,1]]").legends }
    it "creates an entry for each number" do
      expect(legends.length).to eq(8)
    end

    it "keeps track of the values" do
      expect(legends.map(&:value)).to eq([0, 7, 4, 15, 0, 13, 1, 1])
    end
  end

  context "expoding" do
    it "works for [[[[[9,8],1],2],3],4]" do
      result = Snailfish.new("[[[[[9,8],1],2],3],4]").explode
      expect(result).to eq("[[[[0,9],2],3],4]")
    end

    it "works for [7,[6,[5,[4,[3,2]]]]]" do
      result = Snailfish.new("[7,[6,[5,[4,[3,2]]]]]").explode
      expect(result).to eq("[7,[6,[5,[7,0]]]]")
    end

    it "works for [[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]" do
      result = Snailfish.new("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]").explode
      expect(result).to eq("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")
    end
  end

  context "splitting" do
    it "[[[[0,7],4],[15,[0,13]]],[1,1]]" do
      result = Snailfish.new("[[[[0,7],4],[15,[0,13]]],[1,1]]").split
      expect(result).to eq("[[[[0,7],4],[[7,8],[0,13]]],[1,1]]")
    end
    it "works for [[[[0,7],4],[[7,8],[0,13]]],[1,1]]" do
      result = Snailfish.new("[[[[0,7],4],[[7,8],[0,13]]],[1,1]]").split
      expect(result).to eq("[[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]")
    end
  end
end
