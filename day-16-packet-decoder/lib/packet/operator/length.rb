module Packet
  module Operator
    class Length < Packet::Operator::Base
      def my_length
        3 + 3 + 1 + 15 + subpacket_length()
      end

      def my_subpackets
        base_offset = 3 + 3 + 1 + 15
        offset = 0
        subpackets = []
        subcode = @code[base_offset, subpacket_length()]
        while offset < subpacket_length()
          subpacket = PacketFactory.from_code(subcode[offset..-1])
          subpackets << subpacket
          offset += subpacket.my_length()
        end
        subpackets
      end

      def subpacket_length
        @code[7, 15].to_i(2)
      end
    end
  end
end
