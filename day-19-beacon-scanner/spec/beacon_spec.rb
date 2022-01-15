require 'rspec'
require 'bootstrapper'

RSpec.describe Beacon do
  context 'initialize' do
    let(:beacon) do
      scanner = Scanner.new(0)
      Beacon.new('0,2,1', scanner)
    end

    it 'has a base scanner' do
      expect(beacon.scanner).to be_kind_of(Scanner)
    end

    it 'has coordinates relative to its base scanner' do
      expect(beacon.x).to eq(0)
      expect(beacon.y).to eq(2)
      expect(beacon.z).to eq(1)
    end

    it 'has a distance to all other beacons to the same base scanner' do
      expect(beacon.distances).to eq({})
    end
  end
end
