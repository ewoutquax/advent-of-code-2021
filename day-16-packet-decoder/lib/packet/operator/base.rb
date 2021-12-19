module Packet
  module Operator
    class Base < Packet::Base
      def sum_version_ids
        packet_version() + my_subpackets().map(&:sum_version_ids).sum
      end

      def value
        exec_operator()
      end

      private

      def exec_operator
        values = my_subpackets().map(&:value).compact

        case packet_type_id()
        when 0
          values.inject(&:+)
        when 1
          values.inject(&:*)
        when 2
          values.min
        when 3
          values.max
        when 5
          values[0] > values[1] ? 1 : 0
        when 6
          values[0] < values[1] ? 1 : 0
        when 7
          values[0] == values[1] ? 1 : 0
        end
      end
    end
  end
end
