module Puzzle
  class << self
    Y_MULTIPLIER = 1_500

    def count_unique_dots_after_one_fold(input = nil)
      coordinates, folds = (input || read_file())

      locations = parse_coordinates(coordinates)
      locations = execute_fold(folds.first, locations)

      locations.size
    end

    def fold_and_draw(input = nil)
      coordinates, folds = (input || read_file())

      folded_locations =
        folds.inject(parse_coordinates(coordinates)) do |unfolded_locations, fold|
          execute_fold(fold, unfolded_locations)
        end

      draw(folded_locations)
    end

    private

    def draw(locations)
      max_y = (locations.max / Y_MULTIPLIER).floor
      max_x = locations.map { |l| l % Y_MULTIPLIER }.max

      (0..max_y).to_a.each do |y|
        (0..max_x).to_a.each do |x|
          location = encode_location(x, y)
          sign = (locations.include?(location)) ? "#" : " "

          print sign
        end
        puts ""
      end
    end

    def parse_coordinates(coordinates)
      coordinates.map do |coordinate|
        x, y = coordinate.split(",").map(&:to_i)
        encode_location(x, y)
      end
    end

    def execute_fold(fold, locations)
      instruction = fold[11..-1]
      fold_axis, index = instruction.split("=")

      locations.map do |location|
        x, y = decode_location(location)

        new_x, new_y = case fold_axis
          when "y"
            row_nr = index.to_i
            if y > row_nr
              [x, 2 * row_nr - y]
            else
              [x, y]
            end
          when "x"
            column_nr = index.to_i
            if x > column_nr
              [2 * column_nr - x, y]
            else
              [x, y]
            end
          end

        encode_location(new_x, new_y)
      end.uniq
    end

    def encode_location(x, y)
      y * Y_MULTIPLIER + x
    end

    def decode_location(location)
      x = location % Y_MULTIPLIER
      y = (location - x) / Y_MULTIPLIER

      [x, y]
    end

    def read_file()
      File.read("input.txt").split("\n\n").map { |l| l.split("\n") }
    end
  end
end
