# frozen-string-literal: true

# Solve advent-of-code puzzle 2021-20: Trench map
module Puzzle
  class << self
    def count_hightlighted_pixels_after_iterations(iterations, lines = nil)
      lines ||= read_file

      image = Image.parse(lines)
      image.draw

      iterations.times do |iteration|
        default = iteration.even? ? '.' : '#'
        image.enhance(background_value: default)
        image.draw
      end

      hightlighted_pixels = image.all_pixels.select { |p| p.value == '#' }
      hightlighted_pixels.count
    end

    private

    def read_file
      File.read('input.txt').split("\n")
    end
  end
end
