# frozen-string-literal: true

require 'rspec'
require 'bootstrapper'

RSpec.describe Scanner do
  let(:lines_scanner_0) do
    [
      '--- scanner 0 ---',
      '404,-588,-901',
      '528,-643,409',
      '-838,591,734',
      '390,-675,-793',
      '-537,-823,-458',
      '-485,-357,347',
      '-345,-311,381',
      '-661,-816,-575',
      '-876,649,763',
      '-618,-824,-621',
      '553,345,-567',
      '474,580,667',
      '-447,-329,318',
      '-584,868,-557',
      '544,-627,-890',
      '564,392,-477',
      '455,729,728',
      '-892,524,684',
      '-689,845,-530',
      '423,-701,434',
      '7,-33,-71',
      '630,319,-379',
      '443,580,662',
      '-789,900,-551',
      '459,-707,401'
    ]
  end

  let(:lines_scanner_1) do
    [
      '--- scanner 1 ---',
      '686,422,578',
      '605,423,415',
      '515,917,-361',
      '-336,658,858',
      '95,138,22',
      '-476,619,847',
      '-340,-569,-846',
      '567,-361,727',
      '-460,603,-452',
      '669,-402,600',
      '729,430,532',
      '-500,-761,534',
      '-322,571,750',
      '-466,-666,-811',
      '-429,-592,574',
      '-355,545,-477',
      '703,-491,-529',
      '-328,-685,520',
      '413,935,-424',
      '-391,539,-444',
      '586,-435,557',
      '-364,-763,-893',
      '807,-499,-711',
      '755,-354,-619',
      '553,889,-390'
    ]
  end

  let(:lines_scanner_4) do
    [
      '--- scanner 4 ---',
      '727,592,562',
      '-293,-554,779',
      '441,611,-461',
      '-714,465,-776',
      '-743,427,-804',
      '-660,-479,-426',
      '832,-632,460',
      '927,-485,-438',
      '408,393,-506',
      '466,436,-512',
      '110,16,151',
      '-258,-428,682',
      '-393,719,612',
      '-211,-452,876',
      '808,-476,-593',
      '-575,615,604',
      '-485,667,467',
      '-680,325,-822',
      '-627,-443,-432',
      '872,-547,-609',
      '833,512,582',
      '807,604,487',
      '839,-516,451',
      '891,-625,532',
      '-652,-548,-490',
      '30,-46,-14'
    ]
  end

  context 'parsing' do
    let(:scanner) { Scanner.parse(lines_scanner_0) }

    it 'has a number' do
      expect(scanner.number).to eq('0')
    end

    it 'has a list of beacons' do
      expect(scanner.beacons).to be_kind_of(Array)
      expect(scanner.beacons.length).to eq(25)
      expect(scanner.beacons.first).to be_kind_of(Beacon)
    end

    it 'sets the distances to other beacons' do
      beacon = scanner.beacons.first

      expect(beacon.distances).to be_kind_of(Hash)
      expect(beacon.distances.keys.length).to eq(24)
    end
  end

  context 'matching' do
    let(:scanner0) { Scanner.parse(lines_scanner_0) }
    let(:scanner1) { Scanner.parse(lines_scanner_1) }
    let(:scanner4) { Scanner.parse(lines_scanner_4) }

    it 'can match four matching beacons between scanner0 and another scanner' do
      scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to =
        scanner1.find_matching_beacons_from_scanner0(scanner0)

      expect(scanner1_beacon.location).to eq([686, 422, 578])
      expect(scanner0_beacon.location).to eq([-618, -824, -621])
    end

    it 'can convert its beacon-location, relative to scanner0' do
      scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to =
        scanner1.find_matching_beacons_from_scanner0(scanner0)

      scanner1.transformation_rules =
        Helpers.transformation_rules(scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to)

      scanner1.location =
        Helpers.calculate_scanner_location(scanner0_beacon, scanner1_beacon, scanner1.transformation_rules)

      scanner1.add_converted_beacons_to_scanner0(scanner0)

      # scanner0.beacons + scanner1.beacons - matching = 25 + 25 - 12 = 38
      expect(scanner0.beacons.length).to eq(38)
      expect(scanner1.converted).to eq(true)
    end
  end
end
