class Octopus
  attr_reader :energy, :flashed_this_turn

  def initialize(energy)
    @energy = energy

    @flashed_this_turn = false
    @neighbours = []
  end

  def reset
    if @flashed_this_turn
      @flashed_this_turn = false
      @energy = 0
    end
  end

  def increase_energy
    if @energy >= 9 && !@flashed_this_turn
      @flashed_this_turn = true
      @neighbours.each(&:increase_energy)
    else
      @energy += 1
    end
  end

  def add_neighbour(octopus)
    @neighbours << octopus
  end
end
