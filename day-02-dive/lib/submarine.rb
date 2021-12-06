class Submarine
  attr_reader :horizontal, :depth

  def initialize()
    @depth = 0
    @horizontal = 0
    @aim = 0
  end

  def execute_step(step)
    motion, value = step.split(" ")

    self.send(motion.to_sym, value.to_i)
  end

  private

  def forward(value)
    @horizontal += value
  end

  def up(value)
    @depth -= value
  end

  def down(value)
    @depth += value
  end
end
