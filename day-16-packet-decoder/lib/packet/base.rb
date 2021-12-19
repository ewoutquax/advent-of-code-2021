module Packet
  class Base
    def initialize(code)
      @code = code
    end

    def packet_type_id
      @code[3, 3].to_i(2)
    end

    def packet_version
      @code[0, 3].to_i(2)
    end

    def length_type_id
      @code[6, 1]
    end

    def type
      packet_type_id() == 4 ? :literal : :operator
    end
  end
end
