module TradeMetal
  @@metals = {}

  def self.add(coin, unit_price)
    @@metals[coin.to_sym] = unit_price
  end

  def self.get_value(coin)
    @@metals[coin.to_sym]
  end
end
