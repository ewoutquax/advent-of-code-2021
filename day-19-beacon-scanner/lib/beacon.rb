# frozen-string-literal: true

# Holds location relative to parent-scanner, and the distances to all beacons for the same scanner.
# These distances should help find matching beacons with other scanners
class Beacon
  attr_reader :x, :y, :z, :scanner, :distances

  def initialize(string, scanner)
    scanner.is_a?(Scanner) || raise(ArgumentError, "expected class scanner, got #{scanner.class}")

    @x, @y, @z = string.split(',').map(&:to_i)
    @scanner = scanner

    @distances = {}
  end

  def location
    [@x, @y, @z]
  end

  def vector(beacon)
    x0, y0, z0 = location
    x1, y1, z1 = beacon.location

    [x1 - x0, y1 - y0, z1 - z0]
  end

  def add_distance_to_beacon(beacon)
    distance =
      ((beacon.x - @x)**2 + (beacon.y - @y)**2 + (beacon.z - @z)**2)**0.5

    @distances[distance] = beacon
  end

  def convert_and_add_to_scanner0(scanner0)
    converted_location = convert_location

    beacon = Beacon.new(converted_location, scanner0)
    scanner0.add_beacon(beacon)
  end

  private

  def convert_location
    new_x, new_y, new_z =
      scanner.transformation_rules.each_with_object([]) do |(arg0, (arg1, multiplier)), acc|
        acc << multiplier * send(arg1) + scanner.send(arg0)
      end

    [
      new_x, new_y, new_z
    ].join(',')
  end
end
