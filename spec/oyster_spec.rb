require 'oyster'

describe Oyster do
  # subject { described_class.new }

  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can add money to the balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it 'has a maximum limit' do
      limit = Oyster::MAX_LIMIT
      subject.top_up(1)
      expect{ subject.top_up(limit) }.to raise_error "Maximum limit reached!"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'cand deduct the fare from balance' do
      expect{ subject.deduct(1) }.to change{ subject.balance }.by -1
    end
  end
end
