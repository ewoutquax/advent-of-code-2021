module Puzzle
  class << self
    Y_MULTIPLIER = 101

    def count_flashes_after_steps(nr_steps, lines = nil)
      cumulative_flashes_for_steps(
        nr_steps,
        build_map_with_locations(lines || read_file())
      )
    end

    def find_step_when_all_flash(lines = nil)
      count_steps_until_all_flash(
        build_map_with_locations(lines || read_file())
      )
    end

    private

    def cumulative_flashes_for_steps(remaining_steps, octopusses)
      remaining_steps == 0 and return 0

      flashes_for_step(octopusses) +
        cumulative_flashes_for_steps(remaining_steps - 1, octopusses)
    end

    def count_steps_until_all_flash(octopusses, step = 1)
      flashes_for_step(octopusses) == octopusses.length and return step

      count_steps_until_all_flash(octopusses, step + 1)
    end

    def flashes_for_step(octopusses)
      flashes =
        octopusses
          .each(&:increase_energy)
          .select(&:flashed_this_turn)
          .count
      octopusses.each(&:reset)

      flashes
    end

    def build_map_with_locations(lines)
      octopusses = {}

      lines.each.with_index do |line, y|
        line.split(//).each.with_index do |energy, x|
          octopusses[y * Y_MULTIPLIER + x] = Octopus.new(energy.to_i)
        end
      end

      link_neighbouring_octopusses(octopusses).values
    end

    def link_neighbouring_octopusses(octopusses)
      max_index = octopusses.keys.max
      max_x = max_index % Y_MULTIPLIER
      max_y = (max_index - max_x) / Y_MULTIPLIER

      octopusses.each do |index, location|
        x = index % Y_MULTIPLIER
        y = (index - x) / Y_MULTIPLIER

        [
          [-1, -1], [0, -1], [1, -1],
          [-1, 0], [1, 0],
          [-1, 1], [0, 1], [1, 1],
        ].each do |v_x, v_y|
          n_x = x + v_x
          n_y = y + v_y

          n_x >= 0 && n_y >= 0 && n_x <= max_x && n_y <= max_y &&
            octopusses[index].add_neighbour(octopusses[n_y * Y_MULTIPLIER + n_x])
        end
      end
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
