require_relative '../merchant_guide'

RSpec.describe MerchantGuide do
  describe '#initialize' do
    let(:guide) { MerchantGuide.new('It is a test') }
    let(:fail_guide) { MerchantGuide.new('') }

    it 'should initialize @words' do
      expect(guide.instance_variable_get(:@words)).to eq(%w(It is a test))
    end

    it 'should initialize @line' do
      expect(guide.instance_variable_get(:@line)).to eq('It is a test')
    end

    it 'should not initialize @words when param is blank' do
      expect(fail_guide.instance_variable_get(:@words)).to be_nil
    end

    it 'should not initialize @line when param is blank' do
      expect(fail_guide.instance_variable_get(:@line)).to be_nil
    end
  end

  describe '#compute_line' do
    context 'when line is an assigment' do
      it 'should add a word to dictionary' do
        guide = MerchantGuide.new('prok is V')
        guide.compute_line
        expect(Translator.dictionary).to include({ prok: 'V'})
      end
    end

    context 'when line is a Credit statement' do
      it 'should add a new metal' do
        guide = MerchantGuide.new('prok Silver is 10 Credits')
        guide.compute_line
        expect(TradeMetal.get_value(:Silver)).to eq(2)
      end

      it "should not add a new metal when 'Credits' is not present on statement" do
        guide = MerchantGuide.new('prok Iron is 99')
        expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        expect(TradeMetal.get_value(:Iron)).to be_nil
      end

      it "should not add a new metal when 'Credit value' is not present on statement" do
        guide = MerchantGuide.new('prok Iron is Credits')
        expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        expect(TradeMetal.get_value(:Iron)).to be_nil
      end

      it "should not add a new metal when 'metal' is not present on statement" do
        guide = MerchantGuide.new('prok is 99 Credits')
        expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
      end

      it "should not add a new metal when 'galatic words' are not present on statement" do
        guide = MerchantGuide.new('Iron is 99 Credits')
        expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        expect(TradeMetal.get_value(:Iron)).to be_nil
      end
    end

    context 'when statement is an question' do
      context 'how much' do
        it 'should print the correct answer' do
          guide = MerchantGuide.new('how much is prok ?')
          expect { guide.compute_line }.to output("prok is 5\n").to_stdout
        end

        it "should print error message when 'galatic words' are not present on statement" do
          guide = MerchantGuide.new('how much is ?')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end

        it "should print error message when 'question mark' is not present on statement" do
          guide = MerchantGuide.new('how much is prok')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end

        it "should print error message when 'question mark' has no spaces from word" do
          guide = MerchantGuide.new('how much is prok?')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end

        it "should print error message when question is mal formed" do
          guide = MerchantGuide.new('how is prok ?')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end
      end

      context 'how many' do
        it 'should print the correct answer' do
          guide = MerchantGuide.new('how many Credits is prok Silver ?')
          expect { guide.compute_line }.to output("prok Silver is 10 Credits\n").to_stdout
        end

        it "should print error message when 'galatic words' are not present on statement" do
          guide = MerchantGuide.new('how many Credits is Silver ?')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end

        it "should print error message when 'question mark' is not present on statement" do
          guide = MerchantGuide.new('how many Credits is prok Silver')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end

        it "should print error message when 'question mark' has no spaces from word" do
          guide = MerchantGuide.new('how many Credits is prok Silver?')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end

        it "should print error message when question is mal formed" do
          guide = MerchantGuide.new('how many is prok Silver ?')
          expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
        end
      end
    end

    context 'mal formed strings' do
      it 'should print error message' do
        guide = MerchantGuide.new('I like dogs!')
        expect { guide.compute_line }.to output("I have no idea what you are talking about\n").to_stdout
      end
    end
  end
end
