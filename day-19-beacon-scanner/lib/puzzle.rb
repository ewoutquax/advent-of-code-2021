module Puzzle
  class << self
    def count_unique_beacons(lines = nil)
      groups = lines || read_file

      scanner0, other_scanners = convert_locations_to_scanner0(groups)

      t = other_scanners.map { |s| "#{s.number}: #{s.location.join(',')}" }
      puts ''
      puts 'Scanner locations'
      puts '-----------------'
      puts t

      scanner0.beacons.length
    end

    def max_manhattan_distance(lines = nil)
      groups = lines || read_file

      scanner0, other_scanners = convert_locations_to_scanner0(groups)

      all_scanners = other_scanners + [scanner0]

      max = 0
      all_scanners.each do |scanner_from|
        all_scanners.each do |scanner_to|
          distance = Helpers.manhattan_distance(scanner_from, scanner_to)
          max < distance && max = distance
        end
      end

      max
    end

    private

    def convert_locations_to_scanner0(groups)
      scanners = groups.map { |group| Scanner.parse(group) }
      scanner0 = scanners.find { |scanner| scanner.number == '0' }
      other_scanners = scanners - [scanner0]

      while other_scanners.any? { |scanner| scanner.converted == false }
        other_scanners.select { |s| s.converted == false }.each do |scanner|
          result = scanner.find_matching_beacons_from_scanner0(scanner0)

          result == :no_matches and next

          scannerX_beacon, scannerX_beacon_to, scanner0_beacon, scanner0_beacon_to = result

          scanner.transformation_rules =
            Helpers.transformation_rules(
              scanner0_beacon,
              scanner0_beacon_to,
              scannerX_beacon,
              scannerX_beacon_to
            )
          scanner.location =
            Helpers.calculate_scanner_location(
              scanner0_beacon,
              scannerX_beacon,
              scanner.transformation_rules
            )
          scanner.add_converted_beacons_to_scanner0(scanner0)
        end
      end

      [scanner0, other_scanners]
    end

    def read_file
      File.read('input.txt').split("\n\n").map { |group| group.split("\n") }
    end
  end
end
