# README

# System dependencies

* Ruby 2.3.1
* rspec

# How do I run this app?

```ruby main.rb input.txt```

# How do I run the test suite?

```rspec spec```

# Overview

1. Main: Responsible for opening the input file and give each line to the MerchantGuide.
2. MerchantGuide: Responsible for receiving the message and do the correct job for that message. Usually get a message, get the value of the metal with TradeMetal and combines with the unit given by Translator.
3. Translator: Keep a dictionary between galactic and roman numerals. Also, translate it to a integer number.
4. TradeMetal: Keep the name and the unit price of a metal.
