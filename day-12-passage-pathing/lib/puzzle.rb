module Puzzle
  class << self
    def find_all_paths_to_end(lines = nil)
      caves = Cave.parse_caves(lines ||= read_file())

      find_valid_paths([caves["start"]]).flatten
    end

    def find_all_paths_with_double_small_cave_to_end(lines = nil)
      caves = Cave.parse_caves(lines ||= read_file())

      find_valid_paths([caves["start"]], true).flatten
    end

    private

    def find_valid_paths(path, allow_one_double_small_cave = false)
      current_cave = path.last
      current_cave.name == "end" and return path.map(&:name).join(",")

      current_cave
        .reachable_caves(path, allow_one_double_small_cave)
        .map { |cave| find_valid_paths(path + [cave], allow_one_double_small_cave) }
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
