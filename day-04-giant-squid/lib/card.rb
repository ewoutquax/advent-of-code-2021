class Card
  attr_reader :numbers, :marks

  def initialize(numbers)
    @numbers = numbers
    @marks =
      (0..4).to_a.map do
        [0, 0, 0, 0, 0]
      end
  end

  def mark_number(number)
    @numbers.each.with_index do |row, row_index|
      if (idx = row.index(number))
        @marks[row_index][idx] = 1
      end
    end
  end

  def winner?
    !!(winning_row_horizontal || winning_row_vertical)
  end

  def winning_row
    winning_row_horizontal || winning_row_vertical
  end

  def unmarked_numbers
    (0..4).to_a.map do |y|
      (0..4).to_a.inject([]) do |acc, x|
        @marks[y][x] == 0 && acc << @numbers[y][x]

        acc
      end
    end.flatten
  end

  private

  def winning_row_horizontal
    (0..4).to_a.inject(nil) do |acc, idx|
      @marks[idx].join == "11111" && acc = @numbers[idx]
      acc
    end
  end

  def winning_row_vertical
    (0..4).to_a.inject(nil) do |acc, idx|
      @marks.map { |row| row[idx] }.join == "11111" &&
        acc = @numbers.map { |row| row[idx] }

      acc
    end
  end
end
