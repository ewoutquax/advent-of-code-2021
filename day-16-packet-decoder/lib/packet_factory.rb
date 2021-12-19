module PacketFactory
  class << self
    def from_hex(hex_code)
      binary = hex_code.to_i(16).to_s(2)
      code = required_padding_zeros(binary.length) + binary

      self.from_code(code)
    end

    def from_code(code)
      base = Packet::Base.new(code)
      if base.type == :literal
        Packet::Literal.new(code)
      else
        if base.length_type_id == "0"
          Packet::Operator::Length.new(code)
        else
          Packet::Operator::Count.new(code)
        end
      end
    end

    private

    def required_padding_zeros(orig_length)
      required_padding_zeros = (orig_length % 4 == 0) ? 0 : 4 - orig_length % 4
      "0" * required_padding_zeros
    end
  end
end
