# frozen-string-literal: true

# Holds the current and next value of the pixel
# and references to the 8 neighbouring pixels.
# Since the order of the pixels matter, the are identified by keys
class Pixel
  attr_reader :value, :new_value

  NAMED_VECTORS = {
    up_left: [-1, -1],
    up: [0, -1],
    up_right: [1, -1],
    left: [-1, 0],
    center: [0, 0],
    right: [1, 0],
    down_left: [-1, 1],
    down: [0, 1],
    down_right: [1, 1]
  }.freeze

  def initialize(value, x, y)
    @value = value
    @x = x
    @y = y

    @next_value = nil

    @neighbours = {
      up_left: nil,
      up: nil,
      up_right: nil,
      left: nil,
      center: self,
      right: nil,
      down_left: nil,
      down: nil,
      down_right: nil
    }
  end

  def enhance(enhancement, background_value)
    string =
      NAMED_VECTORS.keys.map do |vector_key|
        @neighbours[vector_key].nil? ? background_value : @neighbours[vector_key].value
      end

    enhancement_index =
      string
      .join
      .tr('.', '0')
      .tr('#', '1')
      .to_i(2)

    @new_value = enhancement[enhancement_index]
    [string, @new_value]
  end

  def link_to_neighbours(mapped_pixels)
    NAMED_VECTORS.each do |vector_key, (vx, vy)|
      mapped_pixels.key?(@y + vy) && mapped_pixels[@y + vy].key?(@x + vx) &&
        @neighbours[vector_key] = mapped_pixels[@y + vy][@x + vx]
    end
  end

  def update_value_with_next_value
    set_value(@next_value)
    @next_value = nil
  end

  def neighbours
    @neighbours.values.reject(&:nil?)
  end

  def set_value(value)
    if value != '#' || value != '.'
      puts "set_value with '#{value}'"
      raise("Invalid value for @value: #{value}")
    end
    @value = value
  end
end
