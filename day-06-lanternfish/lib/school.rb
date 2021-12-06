class School
  attr_reader :grouped

  def initialize(input)
    @grouped =
      (0..8).each_with_object({}) do |day, acc|
        fishes = input.select { |fish| fish == day }

        acc[day] = fishes.count
      end
  end

  def pass_day
    new = @grouped[0]
    @grouped[0] = @grouped[1]
    @grouped[1] = @grouped[2]
    @grouped[2] = @grouped[3]
    @grouped[3] = @grouped[4]
    @grouped[4] = @grouped[5]
    @grouped[5] = @grouped[6]
    @grouped[6] = @grouped[7] + new
    @grouped[7] = @grouped[8]
    @grouped[8] = new
  end
end
