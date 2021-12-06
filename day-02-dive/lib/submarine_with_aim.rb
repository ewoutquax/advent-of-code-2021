class SubmarineWithAim < Submarine
  private

  def forward(value)
    super(value)
    @depth += @aim * value
  end

  def up(value)
    @aim -= value
  end

  def down(value)
    @aim += value
  end
end
