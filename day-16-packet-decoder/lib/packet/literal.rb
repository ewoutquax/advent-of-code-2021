module Packet
  class Literal < Packet::Base
    def sum_version_ids
      packet_version()
    end

    def value
      output = ""
      count_groups().times do |count|
        index = 6 + count * 5
        output += @code[index + 1, 4]
      end

      output.to_i(2)
    end

    def my_length
      3 + 3 + count_groups() * 5
    end

    private

    def count_groups
      index = 6
      count = 1
      while @code[index] == "1"
        index += 5
        count += 1
      end
      count
    end
  end
end
