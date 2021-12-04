module Puzzle
  class << self
    def get_final_score_first_win(input = nil)
      drawns, cards_numbers = input || read_file

      cards =
        cards_numbers.map do |card_numbers|
          Card.new(card_numbers)
        end

      first_winner = nil
      while first_winner == nil
        current_draw = drawns.shift
        cards.each { |card| card.mark_number(current_draw) }

        first_winner = cards.detect { |card| card.winner? }
      end

      first_winner.unmarked_numbers.sum * current_draw
    end

    def get_final_score_last_win(input = nil)
      drawns, cards_numbers = input || read_file

      cards =
        cards_numbers.map do |card_numbers|
          Card.new(card_numbers)
        end

      while cards.size > 1
        current_draw = drawns.shift
        cards.each { |card| card.mark_number(current_draw) }

        cards = cards.select { |card| !card.winner? }
      end

      last_card = cards.first
      while !last_card.winner?
        current_draw = drawns.shift
        last_card.mark_number(current_draw)
      end

      last_card.unmarked_numbers.sum * current_draw
    end

    private

    def read_file
      data = File.read("input.txt").split("\n\n")

      drawns = data.shift.split(",").map(&:to_i)

      cards_numbers =
        data.map do |row|
          row.gsub("  ", " ").split("\n").map { |r| r.split(" ").map(&:to_i) }
        end

      [drawns, cards_numbers]
    end
  end
end
