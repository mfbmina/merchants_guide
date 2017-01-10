require_relative 'merchant_guide'

if ARGV.size == 0
  puts "Must give a file"
  exit 1
else
  File.open(ARGV[0], "r").each_line do |line|
    guide = MerchantGuide.new(line)
    guide.compute_line
  end
end
