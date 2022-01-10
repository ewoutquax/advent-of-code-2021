module Puzzle
  class << self
    private

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
