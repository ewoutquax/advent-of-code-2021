class Legend
  attr_reader :depth, :start_position,
              :is_left_number_in_pair,
              :is_right_number_in_pair,
              :previous, :next

  def initialize(depth, value, start_position)
    @depth = depth
    @orig_value = value
    @start_position = start_position

    @current_value = nil

    @is_left_number_in_pair = false
    @is_right_number_in_pair = false

    @previous = nil
    @next = nil
  end

  def append_value(number)
    @orig_value << number
  end

  def value
    @current_value ||= @orig_value.to_i
  end

  def increase(increasement)
    @current_value = value + increasement
  end

  def before_location
    @start_position - 1
  end

  def after_location
    @start_position + @orig_value.length
  end

  def set_left_number_in_pair
    @is_left_number_in_pair = true
  end

  def set_right_number_in_pair
    @is_right_number_in_pair = true
  end

  def in_pair?
    @is_left_number_in_pair || @is_right_number_in_pair
  end

  def set_previous(legend)
    @previous = legend
    legend.set_next(self)
  end

  def set_next(legend)
    @next = legend
  end
end

# [7,[6,[5,[4,[3,2]]]]]
# x----|----+----|----+----|----+
