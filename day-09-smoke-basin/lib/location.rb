class Location
  attr_reader :height, :basin

  def initialize(height)
    @height = height
    @neighbours = []
    @basin = nil
  end

  def is_low_point?
    @neighbours.all? { |neighbour| @height < neighbour.height }
  end

  def risk
    @height + 1
  end

  def add_neighbour(location)
    @neighbours << location
  end

  def extend_basin(basin)
    @basin = basin
    basin.add_location(self)

    @neighbours.each do |neighbour|
      neighbour.height < 9 && neighbour.basin.nil? && neighbour.extend_basin(basin)
    end
  end
end
