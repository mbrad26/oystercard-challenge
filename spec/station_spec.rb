require 'station'

describe Station do
  subject(:station){ described_class.new('Old Street', 3) }

  it 'has a name' do
    expect(station.name).to be_instance_of String
  end

  it 'has a zone' do
    expect(station.zone).to be_instance_of Integer
  end
end
