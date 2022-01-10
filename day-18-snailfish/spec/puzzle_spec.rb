require "rspec"
require "bootstrapper"

RSpec.describe Puzzle do
  let(:example_numbers) {
    [
      "[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]",
      "[[[5,[2,8]],4],[5,[[9,9],0]]]",
      "[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]",
      "[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]",
      "[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]",
      "[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]",
      "[[[[5,4],[7,7]],8],[[8,3],8]]",
      "[[9,3],[[9,9],[6,[4,9]]]]",
      "[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]",
      "[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]",
    ]
  }

  context "sample" do
    it "can add a list of numbers" do
      numbers =
        [
          "[1,1]",
          "[2,2]",
          "[3,3]",
          "[4,4]",
          "[5,5]",
          "[6,6]",
        ]

      result = Puzzle.add_numbers(numbers)

      expect(result).to eq("[[[[5,0],[7,4]],[5,5]],[6,6]]")
    end
    it "can add another list of numbers" do
      result = Puzzle.add_numbers(example_numbers)

      expect(result).to eq("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]")
    end
  end

  context "magnitude" do
    it "for [[1,2],[[3,4],5]]" do
      expect(Puzzle.magnitude("[[1,2],[[3,4],5]]")).to eq("143")
    end
    it "for [[[[5,0],[7,4]],[5,5]],[6,6]]" do
      expect(Puzzle.magnitude("[[[[5,0],[7,4]],[5,5]],[6,6]]")).to eq("1137")
    end
  end

  context "part 1" do
    it "solve example" do
      expect(Puzzle.magnitude_of_list_of_numbers(example_numbers)).to eq("4140")
    end

    it "solve puzzle" do
      expect(Puzzle.magnitude_of_list_of_numbers()).to eq("4140")
    end
  end

  context "part 2" do
    it "solve example" do
      expect(Puzzle.find_largest_snailfish_magnitude(example_numbers)).to eq(3993)
    end

    it "solve puzzle" do
      expect(Puzzle.find_largest_snailfish_magnitude()).to eq(3993)
    end
  end
end
