module Translator
  @@dictionary = {}

  def self.dictionary
    @@dictionary
  end

  def self.add_to_dictionary(key, value)
    @@dictionary[key.to_sym] = value
  end

  def self.parse_to_numeral(array)
    roman_string = to_roman(array)
    sum = 0
    default_roman_values.each_pair do |key, value|
      while roman_string.index(key.to_s) == 0
        sum += value
        roman_string.slice!(key.to_s)
      end
    end
    sum
  end

  private

  def self.to_roman(array)
    array.inject('') do |str, element|
      roman_value = dictionary[element.to_sym]
      return '' if roman_value.nil?
      str << roman_value
    end
  end

  def self.default_roman_values
    {
      M: 1000,
      CM: 900,
      D: 500,
      CD: 400,
      C: 100,
      XC: 90,
      L: 50,
      XL: 40,
      X: 10,
      IX: 9,
      V: 5,
      IV: 4,
      I: 1
    }
  end
end
