require 'station'

describe Station do
  subject(:station){ described_class.new('Old Street', 3) }

  it 'has a name' do
    expect(station.name).to eq 'Old Street'
  end

  it 'has a zone' do
    expect(station.zone).to eq 3
  end
end
