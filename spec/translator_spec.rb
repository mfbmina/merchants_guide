require_relative '../translator'

RSpec.describe Translator do
  describe '#self.add_to_dictionary' do
    it 'should add a hash to the dictionary' do
      Translator.add_to_dictionary(:glob, 'I')
      expect(Translator.class_variable_get(:@@dictionary)).to include({ glob: 'I' })
    end
  end

  describe '#self.dictionary' do
    it 'should retrieve the current dictionary' do
      expect(Translator.dictionary).to include({ glob: 'I' })
    end
  end

  describe '#self.parse_to_numeral' do
    it 'should get an array of galaxy words and return the current numeral' do
      array = %w(glob glob)
      expect(Translator.parse_to_numeral(array)).to eq(2)
    end

    it 'should return 0 if it doesnt know a word' do
      array = %w(glob glossssb)
      expect(Translator.parse_to_numeral(array)).to eq(0)
    end
  end
end
