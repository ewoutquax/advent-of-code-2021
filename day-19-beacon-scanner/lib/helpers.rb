# frozen-string-literal: true

module Helpers
  class << self
    def transformation_rules(beacon0_from, beacon0_to, beacon1_from, beacon1_to)
      x_from, y_from, z_from = beacon0_from.vector(beacon0_to)
      x, y, z = beacon1_from.vector(beacon1_to)

      rules = {}
      to = { x: x, y: y, z: z }

      target_arg, value = to.find { |(_k, v)| v.abs == x_from.abs }
      rules[:x] = [target_arg, value == x_from ? 1 : -1]
      target_arg, value = to.find { |(_k, v)| v.abs == y_from.abs }
      rules[:y] = [target_arg, value == y_from ? 1 : -1]
      target_arg, value = to.find { |(_k, v)| v.abs == z_from.abs }
      rules[:z] = [target_arg, value == z_from ? 1 : -1]

      rules
    end

    def calculate_scanner_location(beacon0, beacon1, transformation_rules)
      transformation_rules.each_with_object([]) do |(arg0, (arg1, multiplier)), acc|
        acc << beacon0.send(arg0) - multiplier * beacon1.send(arg1)
      end
    end

    def manhattan_distance(scanner0, scanner1)
      (scanner0.x - scanner1.x).abs +
        (scanner0.y  - scanner1.y).abs +
        (scanner0.z  - scanner1.z).abs
    end
  end
end
