class Snailfish
  attr_reader :legends, :string

  def initialize(string)
    @string = string
    parse()
  end

  def explodable?
    max_depth() > 4
  end

  def splittable?
    @legends.any? { |l| l.value > 9 }
  end

  def split
    splittable =
      @legends.detect { |l| l.value > 9 }

    part_1 =
      [@string[0..splittable.before_location]]
    part_2 =
      [
        "[",
        (splittable.value / 2.0).floor.to_s,
        ",",
        (splittable.value / 2.0).ceil.to_s,
        "]",
      ]
    part_3 =
      [@string[splittable.after_location..-1]]

    [
      part_1,
      part_2,
      part_3,
    ].join
  end

  def explode
    if max_depth() >= 4
      left_explodable = @legends.detect { |l| l.depth == max_depth && l.is_left_number_in_pair }
      right_explodable = left_explodable.next

      left_explodable.previous &&
        left_explodable.previous.increase(left_explodable.value)
      right_explodable.next &&
        right_explodable.next.increase(right_explodable.value)

      part_1 = if left_explodable.previous
          [
            @string[0..left_explodable.previous.before_location],
            left_explodable.previous.value.to_s,
            @string[left_explodable.previous.after_location...left_explodable.before_location],
          ]
        else
          [@string[0...left_explodable.before_location]]
        end

      part_2 = "0"
      part_3 = if right_explodable.next
          [
            @string[right_explodable.after_location + 1..right_explodable.next.before_location],
            right_explodable.next.value.to_s,
            @string[right_explodable.next.after_location..-1],
          ]
        else
          [@string[right_explodable.after_location + 1..-1]]
        end

      [
        part_1,
        part_2,
        part_3,
      ].join
    end
  end

  def magnitude_round
    left = @legends.detect { |l| l.is_left_number_in_pair }
    right = left.next

    magnitude_number = left.value * 3 + right.value * 2

    part_1 =
      [@string[0...left.before_location]]
    part_2 =
      [
        magnitude_number,
      ]
    part_3 =
      [@string[right.after_location + 1..-1]]

    [
      part_1,
      part_2,
      part_3,
    ].join
  end

  private

  def parse
    depth = 0; @legends = []

    # Get values, depths and positions
    @string.split(//).each.with_index do |char, location|
      char == "[" && depth += 1
      char == "]" && depth -= 1

      if char.to_i.to_s == char
        if @legends.last && @legends.last.after_location == location
          @legends.last.append_value(char)
        else
          @legends << Legend.new(depth, char, location)
        end
      end
    end

    # find pairs
    @legends.each.with_index do |legend, index|
      if @string[legend.start_position - 1..-1].match?(/^\[\d+,\d+\]/)
        legend.set_left_number_in_pair
        @legends[index + 1].set_right_number_in_pair
      end
    end

    # link numbers
    @legends.each.with_index do |legend, index|
      index > 0 && @legends[index].set_previous(legends[index - 1])
    end
  end

  def max_depth
    @legends.map(&:depth).max
  end
end
