require_relative '../trade_metal'

RSpec.describe TradeMetal do

  describe '#self.add' do
    it 'should add a new metal to @@metals' do
      TradeMetal.add(:gold, 1000)
      expect(TradeMetal.class_variable_get(:@@metals)).to include({ gold: 1000 })
    end
  end

  describe '#self.get_value' do
    it 'should return a metal value from @@metals' do
      TradeMetal.add(:gold, 1000)
      expect(TradeMetal.get_value(:gold)).to eq(1000)
    end

    it 'should return nil if a metal doesnt exists' do
      expect(TradeMetal.get_value(:silver)).to be_nil
    end
  end
end
