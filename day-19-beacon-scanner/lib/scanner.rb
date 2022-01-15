# frozen-string-literal: true

# Scanner, with number and the references to its beacons.
# The locations of the beacons can be transformed to its location of another scanner (preferable '0')
class Scanner
  attr_accessor :transformation_rules
  attr_reader :number, :beacons, :x, :y, :z, :converted

  def self.parse(lines)
    number = lines.shift.split(' ')[2]
    scanner = new(number)

    lines.each do |line|
      scanner.add_beacon(Beacon.new(line, scanner))
    end

    scanner
  end

  def initialize(number)
    @number = number

    @beacons = []
    @converted = false

    @x = 0
    @y = 0
    @z = 0
  end

  def location=(loc)
    @x, @y, @z = loc
  end

  def location
    [@x, @y, @z]
  end

  def add_beacon(new_beacon)
    @beacons.any? { |beacon| beacon.location == new_beacon.location } and return

    @beacons.each do |beacon|
      beacon.add_distance_to_beacon(new_beacon)
      new_beacon.add_distance_to_beacon(beacon)
    end

    @beacons << new_beacon
  end

  def add_beacon_simple(new_beacon)
    @beacons << new_beacon
  end

  def add_converted_beacons_to_scanner0(scanner0)
    beacons.each { |beacon| beacon.convert_and_add_to_scanner0(scanner0) }
    @converted = true
  end

  def find_matching_beacons_from_scanner0(scanner0)
    scanner0.is_a?(Scanner) || raise(ArgumentError)

    results = []
    beacons.each do |my_beacon|
      my_distances = my_beacon.distances.keys.sort

      scanner0.beacons.each do |beacon0|
        distances0 = beacon0.distances.keys.sort
        matches = my_distances & distances0

        next unless matches.length >= 6

        distance = matches.max
        my_beacon_to = my_beacon.distances[distance]
        beacon0_to = beacon0.distances[distance]

        results << [my_beacon, my_beacon_to, beacon0, beacon0_to]
      end
    end

    if results.any?
      results.first
    else
      :no_matches
    end
  end
end
