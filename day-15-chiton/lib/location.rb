class Location
  attr_reader :risk, :max_distance, :neighbours, :x, :y

  def initialize(risk, x, y)
    @risk = risk
    @x = x
    @y = y

    @is_visited = false
    @is_start = false
    @is_end = false

    @max_distance = Float::INFINITY

    @neighbours = []
  end

  def is_start?
    @is_start
  end

  def is_end?
    @is_end
  end

  def set_start
    @is_start = true
    @max_distance = 0
    @risk = 0
    @is_visited = true
  end

  def set_end
    @is_end = true
  end

  def set_visited
    @is_visited = true
  end

  def unvisited?
    !@is_visited
  end

  def set_max_distance(distance)
    @max_distance > distance &&
      @max_distance = distance
  end

  def add_neighbour(location)
    @neighbours << location
  end
end
