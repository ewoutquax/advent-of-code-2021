module Puzzle
  class << self
    def lowest_risk(input = nil)
      lines = input || read_file()

      locations = build_map_with_locations(lines)

      start_location = locations.detect { |l| l.is_start? }
      end_location = find_path_with_lowest_risk(start_location)

      end_location.max_distance
    end

    private

    def find_path_with_lowest_risk(current_location)
      reachable_locations = {}
      reachable_locations[0] = [current_location]

      current_distance = 0
      until current_location.is_end?
        current_location.is_end? and return current_location
        current_location.set_visited()

        current_location.neighbours.each do |neighbour)
          neighbour_max_distance = current_location.max_distance + neighbour.risk
          neighbour.set_max_distance(neighbour_max_distance)
          reachable_locations[neighbour_max_distance] ||= []
          reachable_locations[neighbour_max_distance] << neighbour
        end

        min_distance = Float::INFINITY
        next_location = nil
        while next_location.nil?
          reachable_locations[current_distance].each do |location|
            if location.unvisited? && min_distance > location.max_distance
              min_distance = location.max_distance
              next_location = location
            end
          end

          if next_location.nil?
            begin
              current_distance += 1
            end while reachable_locations[current_distance].nil?
            puts "Max distance: #{current_distance}, with #{reachable_locations[current_distance].size} reachable_locations"
          end
        end

        current_location = next_location
      end

      current_location
    end

    def build_map_with_locations(lines)
      locations = {}

      max_y = lines.size
      max_x = lines.first.length

      final_max_x = max_x * 5 - 1
      final_max_y = max_y * 5 - 1

      lines.each.with_index do |line, y|
        line.split(//).each.with_index do |risk, x|
          (0..4).to_a.each do |y_multiplier|
            (0..4).to_a.each do |x_multiplier|
              final_risk = risk.to_i + y_multiplier + x_multiplier
              final_risk > 9 && final_risk -= 9

              final_x = x + x_multiplier * max_x
              final_y = y + y_multiplier * max_y
              locations["#{final_x},#{final_y}"] = Location.new(final_risk, final_x, final_y)
            end
          end
        end
      end

      locations.each do |index, location|
        x = location.x
        y = location.y

        x == 0 && y == 0 && location.set_start()
        x == final_max_x && y == final_max_y && location.set_end()

        x > 0 &&
          location.add_neighbour(locations["#{x - 1},#{y}"])
        y > 0 &&
          location.add_neighbour(locations["#{x},#{y - 1}"])
        x < final_max_x &&
          location.add_neighbour(locations["#{x + 1},#{y}"])
        y < final_max_y &&
          location.add_neighbour(locations["#{x},#{y + 1}"])
      end

      locations.values
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
