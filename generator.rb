# semi random number generator

require 'csv'
require 'weighted_randomizer'

count = 1
if ARGV.count > 0
	count = ARGV.first.to_i
end

data = Hash.new

f = CSV.foreach("randgen-data.csv") do |row|
	data[row[0]] = row[1].to_f
end

randomizer = WeightedRandomizer.new(data)

puts randomizer.sample(count)