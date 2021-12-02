class Submarine
  attr_reader :horizontal, :depth

  def initialize(use_aim)
    @use_aim = use_aim

    @depth = 0
    @horizontal = 0
    @aim = 0
  end

  def execute_step(step)
    motion, value = step.split(" ")

    case motion
    when "forward"
      @horizontal += value.to_i

      @use_aim && @depth += @aim * value.to_i
    when "up"
      @use_aim ? @aim -= value.to_i : @depth -= value.to_i
    when "down"
      @use_aim ? @aim += value.to_i : @depth += value.to_i
    end
  end
end
