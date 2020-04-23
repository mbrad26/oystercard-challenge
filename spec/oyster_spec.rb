require 'oyster'

describe Oyster do

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'is initialy not in journey' do
    expect(subject).not_to be_in_journey
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can add money to the balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it 'has a maximum limit' do
      limit = Oyster::MAX_LIMIT
      subject.top_up(limit)
      expect{ subject.top_up(1) }.to raise_error "Maximum limit reached!"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'cand deduct the fare from balance' do
      expect{ subject.deduct(1) }.to change{ subject.balance }.by -1
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'can touch in' do
      subject.top_up(Oyster::FARE)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    context 'when insufiicient funds' do
      it 'raises an error' do
        expect{ subject.touch_in }.to raise_error 'Insufficient funds!'
      end
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'can touch out' do
      subject.top_up(Oyster::FARE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
