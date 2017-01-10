require_relative 'translator'
require_relative 'trade_metal'

class MerchantGuide
  def initialize(line)
    return if line.chomp == ""
    @line = line
    @words = line.split
  end

  def compute_line
    if @words.size == 3 && @words[1] == "is"
      Translator.add_to_dictionary(@words[0], @words[2])
    elsif @words.last == "Credits"
      process_credit_statement
    elsif @words.include?("how") and @words.last == "?"
     process_question
    else
      have_no_idea
    end
  end

  private

  def process_question
    if @line.start_with?("how many Credits is ")
      units = Translator.parse_to_numeral(@words[4..-3])
      metal = TradeMetal.get_value(@words[-2])
      return puts "#{@words[4..-3].join(' ')} #{@words[-2]} is #{(units * metal).to_i} Credits" if valid_int?(units) && metal
    elsif @line.start_with?("how much is ")
      units = Translator.parse_to_numeral(@words[3..-2])
      return puts "#{@words[3..-2].join(' ')} is #{units}" if valid_int?(units)
    end
    have_no_idea
  end

  def process_credit_statement
    @galactic_units = []
    @words.each do |word|
      if Translator.dictionary.keys.include?(word.to_sym)
        @galactic_units << word
      elsif %w(is Credits).include?(word)
        next
      elsif word.to_i == 0
        @coin = word
      else
        @credits = word.to_i
      end
    end
    calculate_credits
  end

  def calculate_credits
    if @coin && !@coin.empty? && valid_int?(@credits) && !@galactic_units.empty? && @galactic_units.size > 0
      units = Translator.parse_to_numeral(@galactic_units)
      if units > 0
        unit_price =  @credits.to_f / units
        return TradeMetal.add(@coin, unit_price)
      end
    end
    have_no_idea
  end

  def have_no_idea
    puts "I have no idea what you are talking about"
  end

  def valid_int?(value)
    value && value > 0
  end
end
