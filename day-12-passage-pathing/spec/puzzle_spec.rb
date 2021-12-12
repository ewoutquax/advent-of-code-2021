require "rspec"
require "bootstrapper"

RSpec.describe Puzzle do
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

  context "samples" do
    it "do one step" do
      lines = ["start-end"]
      paths = Puzzle.find_all_paths_to_end(lines)

      expect(paths).to eq(["start,end"])
    end

    it "do two step" do
      lines = [
        "start-A",
        "A-end",
      ]
      paths = Puzzle.find_all_paths_to_end(lines)

      expect(paths).to eq(["start,A,end"])
    end

    it "do two step, with a dead-end" do
      lines = [
        "start-a",
        "a-b",
        "a-end",
      ]
      paths = Puzzle.find_all_paths_to_end(lines)

      expect(paths).to eq(["start,a,end"])
    end

    it "do two step, with an optional loop" do
      lines = [
        "start-A",
        "A-b",
        "A-end",
      ]

      expected_paths = ["start,A,b,A,end", "start,A,end"]

      paths = Puzzle.find_all_paths_to_end(lines)
      expect(paths).to eq(expected_paths)
    end
  end

  context "part 1" do
    it "solve example" do
      paths = Puzzle.find_all_paths_to_end(@lines)
      expect(paths.size).to eq(10)
    end

    it "solve puzzle" do
      paths = Puzzle.find_all_paths_to_end()
      expect(paths.size).to eq(4912)
    end
  end

  context "part 2" do
    it "solve example" do
      paths = Puzzle.find_all_paths_with_double_small_cave_to_end(@lines)
      expect(paths.size).to eq(36)
    end

    it "solve puzzle" do
      paths = Puzzle.find_all_paths_with_double_small_cave_to_end()
      expect(paths.size).to eq(150004)
    end
  end
end
