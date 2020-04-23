require 'oyster'

describe Oyster do
  let(:fare){ Oyster::FARE }
  let(:entry_station){ double :station }
  let(:exit_station){ double :station}

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'is initialy not in journey' do
    expect(subject).not_to be_in_journey
  end

  it 'stores all journeys in a list' do
    expect(subject.journeys).to be_instance_of Array
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can add money to the balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it 'has a maximum limit' do
      limit = Oyster::MAX_LIMIT
      subject.top_up(limit)
      expect{ subject.top_up(fare) }.to raise_error "Maximum limit reached!"
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'can touch in' do
      subject.top_up(fare)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'can remember the entry station' do
      subject.top_up(fare)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

    context 'when insufiicient funds' do
      it 'raises an error' do
        expect{ subject.touch_in(entry_station) }.to raise_error 'Insufficient funds!'
      end
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(fare)
      subject.touch_in(entry_station)
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    context 'when journey is complete' do
      it 'deducts the fare' do
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by -fare
      end
    end
  end
end
