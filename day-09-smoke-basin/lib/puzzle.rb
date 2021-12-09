module Puzzle
  class << self
    Y_MULTIPLIER = 101

    def sum_risk_of_low_points(lines = nil)
      find_low_points_in_map(lines || read_file())
        .map(&:risk)
        .sum
    end

    def product_of_three_largest_basins(lines = nil)
      find_basins_in_map(lines || read_file())
        .map(&:area_size)
        .sort
        .last(3)
        .inject() { |product, area_size| product * area_size }
    end

    private

    def find_basins_in_map(lines)
      find_low_points_in_map(lines).each_with_object([]) do |low_point, basins|
        basin = Basin.new
        basins << basin
        low_point.extend_basin(basin)
      end
    end

    def find_low_points_in_map(lines)
      build_map_with_locations(lines).select(&:is_low_point?)
    end

    def build_map_with_locations(lines)
      locations = {}

      lines.each.with_index do |line, y|
        line.split(//).each.with_index do |height, x|
          locations[y * Y_MULTIPLIER + x] = Location.new(height.to_i)
        end
      end

      link_neighbouring_locations(locations).values
    end

    def link_neighbouring_locations(locations)
      max_index = locations.keys.max
      max_x = max_index % Y_MULTIPLIER
      max_y = (max_index - max_x) / Y_MULTIPLIER

      locations.each do |index, location|
        x = index % Y_MULTIPLIER
        y = (index - x) / Y_MULTIPLIER
        x > 0 &&
          locations[index].add_neighbour(locations[(y + 0) * Y_MULTIPLIER + x - 1])
        y > 0 &&
          locations[index].add_neighbour(locations[(y - 1) * Y_MULTIPLIER + x + 0])
        x < max_x &&
          locations[index].add_neighbour(locations[(y + 0) * Y_MULTIPLIER + x + 1])
        y < max_y &&
          locations[index].add_neighbour(locations[(y + 1) * Y_MULTIPLIER + x + 0])
      end
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
