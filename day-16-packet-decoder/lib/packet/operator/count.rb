module Packet
  module Operator
    class Count < Packet::Operator::Base
      def my_length
        offset = 3 + 3 + 1 + 11
        number_of_subpackets().times do |counter|
          subcode = @code[offset..-1]
          subpacket = PacketFactory.from_code(subcode)
          subpacket_length = subpacket.my_length()
          offset += subpacket_length
        end
        offset
      end

      def my_subpackets
        offset = 3 + 3 + 1 + 11
        (1..number_of_subpackets()).to_a.map do |counter|
          subcode = @code[offset..-1]
          subpacket = PacketFactory.from_code(subcode)
          offset += subpacket.my_length()
          subpacket
        end
      end

      private

      def number_of_subpackets
        @code[7, 11].to_i(2)
      end
    end
  end
end
