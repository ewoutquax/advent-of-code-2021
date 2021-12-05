class Map
  attr_reader :locations

  def initialize(allow_diagonal)
    @allow_diagonal = allow_diagonal
    @locations = {}
  end

  def draw_rift(line)
    from, to = line.split(" -> ")
    from_x, from_y = from.split(",").map(&:to_i)
    to_x, to_y = to.split(",").map(&:to_i)

    if @allow_diagonal || !diagonal?(from_x, from_y, to_x, to_y)
      list_of_x = build_list(from_x, to_x)
      list_of_y = build_list(from_y, to_y)

      mark_locations(list_of_x, list_of_y)
    end
  end

  def overlapping_locations
    @locations.select { |_location, count| count > 1 }
  end

  private

  def diagonal?(x1, y1, x2, y2)
    x1 != x2 && y1 != y2
  end

  def build_list(from, to)
    if from < to
      (from..to).to_a
    else
      (to..from).to_a.reverse
    end
  end

  def mark_locations(list_of_x, list_of_y)
    list_of_x == [] && list_of_y == [] and return

    list_of_x_size = list_of_x.size
    list_of_y_size = list_of_y.size
    current_x = (list_of_x_size == 1 && list_of_y_size > 1) ? list_of_x.first : list_of_x.shift
    current_y = (list_of_y_size == 1 && list_of_x_size > 1) ? list_of_y.first : list_of_y.shift

    @locations[current_x * 1000 + current_y] ||= 0
    @locations[current_x * 1000 + current_y] += 1

    mark_locations(list_of_x, list_of_y)
  end
end
