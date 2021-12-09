class Basin
  attr_reader :locations

  def initialize
    @locations = []
  end

  def add_location(location)
    @locations << location
  end

  def area_size
    @locations.size
  end
end
