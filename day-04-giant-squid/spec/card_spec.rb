require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Card do
  before do
    @numbers =
      [
        [14, 21, 17, 24, 4],
        [10, 16, 15, 9, 19],
        [18, 8, 23, 26, 20],
        [22, 11, 13, 6, 5],
        [2, 0, 12, 3, 7],
      ]
  end

  let(:card) { Card.new(@numbers) }

  context "instantiating" do
    it "can be instantiated with the numbers" do
      expect(card).to be_kind_of(Card)
    end
    it "has a list of numbers" do
      expect(card.numbers).to be_kind_of(Array)
    end
    it "is has 5 rows of numbers" do
      expect(card.numbers.size).to eq(5)
    end
    it "a row of numbers has 5 numbers" do
      expect(card.numbers.first.size).to eq(5)
    end
  end

  context "draw card" do
    it "can mark a drawn number" do
      card.mark_number(8)

      expect(card.marks[2][1]).to eq(1)
    end
  end

  context "winner" do
    it "returns false for a card without marks" do
      expect(card.winner?).to eq(false)
    end

    it "can tell if the card is a winner via horizontal" do
      card.mark_number(10)
      card.mark_number(16)
      card.mark_number(15)
      card.mark_number(9)
      card.mark_number(19)

      expect(card.winner?).to eq(true)
    end

    it "can tell if the card is a winner via vertical" do
      card.mark_number(4)
      card.mark_number(19)
      card.mark_number(20)
      card.mark_number(5)
      card.mark_number(7)

      expect(card.winner?).to eq(true)
    end
  end

  context "winning_row horizontal" do
    it "returns nil for a card without marks" do
      expect(card.winning_row).to be_nil
    end

    it "can return the completed horizontal row" do
      card.mark_number(10)
      card.mark_number(16)
      card.mark_number(15)
      card.mark_number(9)
      card.mark_number(19)

      expect(card.winning_row).to eq([10, 16, 15, 9, 19])
    end

    it "can return the completed vertical row" do
      card.mark_number(4)
      card.mark_number(19)
      card.mark_number(20)
      card.mark_number(5)
      card.mark_number(7)

      expect(card.winning_row).to eq([4, 19, 20, 5, 7])
    end
  end
end
