# frozen_string_literal: true

module Puzzle
  class << self
    def magnitude_of_list_of_numbers(numbers = nil)
      numbers ||= read_file

      added = add_numbers(numbers)
      magnitude(added)
    end

    def find_largest_snailfish_magnitude(numbers = nil)
      numbers ||= read_file

      largest = 0
      numbers.each do |number1|
        numbers.each do |number2|
          number1 == number2 and next

          result = magnitude(add_numbers([number1, number2])).to_i
          largest < result && largest = result
        end
      end

      largest
    end

    def add_numbers(numbers)
      numbers.inject do |acc, number|
        addition = "[#{acc},#{number}]"

        snail = Snailfish.new(addition)
        while snail.explodable? || snail.splittable?
          result = if snail.explodable?
              snail.explode
            else
              snail.split
            end

          snail = Snailfish.new(result)
        end

        snail.string
      end
    end

    def magnitude(string)
      snail = Snailfish.new(string)
      until snail.string.index("[").nil?
        new_string = snail.magnitude_round
        snail = Snailfish.new(new_string)
      end

      snail.string
    end

    def read_file
      File.read("input.txt").split("\n")
    end
  end
end
