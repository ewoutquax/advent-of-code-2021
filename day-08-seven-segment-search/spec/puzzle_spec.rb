require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
    @digits = [
      "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
      "edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
      "fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
      "fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
      "aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
      "fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
      "dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
      "bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
      "egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
      "gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce",
    ]
  end

  context "part 1" do
    it "solve example" do
      count = Puzzle.count_identifiable_digits_after_pipe(@digits)
      expect(count).to eq(26)
    end

    it "solve puzzle" do
      count = Puzzle.count_identifiable_digits_after_pipe()
      expect(count).to eq(330)
    end
  end

  context "part 2" do
    it "solve short example" do
      line = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"

      hash = Puzzle.sum_deducted_hashes([line])
      expect(hash).to eq(5353)
    end

    it "solve example" do
      summed_hashes = Puzzle.sum_deducted_hashes(@digits)
      expect(summed_hashes).to eq(61229)
    end

    it "solve puzzle" do
      summed_hashes = Puzzle.sum_deducted_hashes()
      expect(summed_hashes).to eq(1010472)
    end
  end
end
