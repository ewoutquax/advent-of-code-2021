module Parser
  OPEN_CLOSE_CHARS = {
    nil => "",
    "(" => ")",
    "{" => "}",
    "[" => "]",
    "<" => ">",
  }

  CHAR_SCORE = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
  }

  class << self
    def line(line)
      match_open_with_close(line.split(//))
    end

    def score_for_autocompletion(string)
      string.split(//).inject(0) do |acc, char|
        acc * 5 + CHAR_SCORE[char]
      end
    end

    private

    def match_open_with_close(chars, current_open_char = nil, result = [:continue])
      # puts "remaining chars / current-open-char / result: #{chars.join} / '#{current_open_char}' / '#{result}'"

      result[0] == :incomplete and return [:incomplete, result[1] + OPEN_CLOSE_CHARS[current_open_char]]
      result == [:continue] or return result
      chars == [] && current_open_char.nil? and return [:valid]
      chars == [] and return [:incomplete, OPEN_CLOSE_CHARS[current_open_char]]

      char = chars.shift

      # puts "current char: #{char}"

      if OPEN_CLOSE_CHARS.values.include?(char)
        # puts "  Found closing char: #{char}"
        if OPEN_CLOSE_CHARS[current_open_char] == char
          # puts "  It matches with the opening char; returning `:continue`"
          [:continue]
        else
          # puts "  mismatch with current-open-char"
          [:corrupt, char]
        end
      elsif OPEN_CLOSE_CHARS.keys.include?(char)
        # puts "  Found opening char: #{char}"
        new_result = match_open_with_close(chars, char)
        match_open_with_close(chars, current_open_char, new_result)
      else
        match_open_with_close(chars, current_open_char, result)
      end
    end
  end
end
