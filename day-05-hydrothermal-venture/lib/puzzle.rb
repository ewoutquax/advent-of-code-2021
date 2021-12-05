module Puzzle
  class << self
    def count_overlapping_venture_locations(vectors = nil, allow_diagonal = false)
      vectors ||= read_file()

      map = Map.new(allow_diagonal)
      vectors.each { |vector| map.draw_rift(vector) }

      map.overlapping_locations.size
    end

    private

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
