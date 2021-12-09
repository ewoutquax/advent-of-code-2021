class Digit
  def initialize
    @segments = {
      "top" => nil,
      "middle" => nil,
      "bottom" => nil,
      "left-top" => nil,
      "left-bottom" => nil,
      "right-top" => nil,
      "right-bottom" => nil,
    }
  end

  def convert_combination(combination)
    is_0?(combination) && 0 ||
    is_1?(combination) && 1 ||
    is_2?(combination) && 2 ||
    is_3?(combination) && 3 ||
    is_4?(combination) && 4 ||
    is_5?(combination) && 5 ||
    is_6?(combination) && 6 ||
    is_7?(combination) && 7 ||
    is_8?(combination) && 8 ||
    is_9?(combination) && 9
  end

  def deduct_letter_locations(line)
    combinations = line.tr(" | ", " ").split(" ").map { |c| c.split(//).sort.join }.sort.uniq

    possibilities = {
      0 => [],
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => [],
      6 => [],
      7 => [],
      8 => [],
      9 => [],
    }

    combinations.each do |combination|
      case combination.length
      when 2
        possibilities[1] = [combination]
      when 3
        possibilities[7] = [combination]
      when 4
        possibilities[4] = [combination]
      when 5
        possibilities[2] << combination
        possibilities[3] << combination
        possibilities[5] << combination
      when 6
        possibilities[0] << [combination]
        possibilities[6] << [combination]
        possibilities[9] << [combination]
      when 7
        possibilities[8] = [combination]
      end
    end

    # top is present in 7, and not in 1
    @segments["top"] = (possibilities[7].first.split(//) - possibilities[1].first.split(//)).first

    # digit 3 is the one from 2, 3 or 5, with the same letters as 1
    digit_3 =
      possibilities[3].detect do |combination|
        (combination.split(//) & possibilities[1].first.split(//)).size == 2
      end

    # left-top is the 4, minus all the letters from 3
    @segments["left-top"] =
      (possibilities[4].first.split(//) - digit_3.split(//)).first

    # middle is the 4, minus the letters from 1, minus left-top
    @segments["middle"] =
      (possibilities[4].first.split(//) - possibilities[1].first.split(//) - [@segments["left-top"]]).first

    # bottom is the 3, minus the letters from 1, minus the top, minus the middle
    @segments["bottom"] =
      (digit_3.split(//) - possibilities[1].first.split(//) - [@segments["top"]] - [@segments["middle"]]).first

    # digit 5 is the one from 2, 3 or 5, with the left-top used
    digit_5 =
      possibilities[3].detect do |combination|
        combination.include?(@segments["left-top"])
      end

    # right-bottom is the matching letter between 5 and 1
    @segments["right-bottom"] =
      (digit_5.split(//) & possibilities[1].first.split(//)).first

    # right-top is 1, minus right-bottom
    @segments["right-top"] =
      (possibilities[1].first.split(//) - [@segments["right-bottom"]]).first

    # left-bottom is the unused one
    @segments["left-bottom"] =
      ("abcdefgh".split(//) - digit_3.split(//) - digit_5.split(//)).first
  end

  private

  def is_0?(combination)
    combination.length == 6 &&
    combination.include?(@segments["left-top"]) &&
    combination.include?(@segments["left-bottom"]) &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["top"]) &&
    combination.include?(@segments["bottom"])
  end

  def is_1?(combination)
    combination.length == 2 &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["right-bottom"])
  end

  def is_2?(combination)
    combination.length == 5 &&
    combination.include?(@segments["left-bottom"]) &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["top"]) &&
    combination.include?(@segments["middle"]) &&
    combination.include?(@segments["bottom"])
  end

  def is_3?(combination)
    combination.length == 5 &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["top"]) &&
    combination.include?(@segments["middle"]) &&
    combination.include?(@segments["bottom"])
  end

  def is_4?(combination)
    combination.length == 4 &&
    combination.include?(@segments["left-top"]) &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["middle"])
  end

  def is_5?(combination)
    combination.length == 5 &&
    combination.include?(@segments["left-top"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["top"]) &&
    combination.include?(@segments["middle"]) &&
    combination.include?(@segments["bottom"])
  end

  def is_6?(combination)
    combination.length == 6 &&
    combination.include?(@segments["left-top"]) &&
    combination.include?(@segments["left-bottom"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["top"]) &&
    combination.include?(@segments["middle"]) &&
    combination.include?(@segments["bottom"])
  end

  def is_7?(combination)
    combination.length == 3 &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["top"])
  end

  def is_8?(combination)
    combination.length == 7
  end

  def is_9?(combination)
    combination.length == 6 &&
    combination.include?(@segments["left-top"]) &&
    combination.include?(@segments["right-top"]) &&
    combination.include?(@segments["right-bottom"]) &&
    combination.include?(@segments["top"]) &&
    combination.include?(@segments["middle"]) &&
    combination.include?(@segments["bottom"])
  end
end
