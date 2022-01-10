require "rspec"
require "bootstrapper"

RSpec.describe Puzzle do
  before do
  end

  context "samples" do
    it "calculate y's" do
      target_y = (-10..-5).to_a

      valid_vs = []
      (0..1_000).to_a.each do |start_v|
        max_y = 0
        y = 0
        v = start_v
        while !(target_y.include?(y)) && y > target_y.min
          if max_y < y
            max_y = y
          end
          y += v
          v -= 1
        end

        if target_y.include?(y)
          valid_vs << start_v
          puts "with initial v #{start_v}, y hits the box at #{y} with a max #{max_y}"
        else
          puts "with initial v #{start_v}, y misses the box with values #{y - v} and #{y}"
        end
      end

      puts "number of distinct valid velocities: '#{valid_vs.uniq.size}'"
    end

    it "calculates x" do
      target_x = (20..30).to_a
      valid_xs = []

      (0..target_x.max).to_a.each do |start_vx|
        (0..1_000).to_a.each do |start_vy|
          x = 0
          y = 0
          v = start_vx
          while !(target_x.include?(x)) && x <= target_x.min && v > 0
            x += v
            v = (v > 0) ? v -= 1 : 0
          end
        end

        if target_x.include?(x)
          valid_xs << start_vx
          puts "with initial v #{start_vx}, x hits the box at #{x}"
        else
          puts "with initial v #{start_vx}, x misses the box with values #{x - v} and #{x}"
        end
      end
    end
  end

  context "part 1" do
    it "solve example"

    it "solve puzzle"
  end

  context "part 2" do
    it "solve example"

    it "solve puzzle"
  end
end
