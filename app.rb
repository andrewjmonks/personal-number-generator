# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
require 'csv'
Bundler.require


data = Hash.new

f = CSV.foreach("randgen-data.csv") do |row|
  data[row[0]] = row[1].to_f
end

randomizer = WeightedRandomizer.new(data)



get '/' do 
  randomizer.sample(1)
end

get '/*' do
  if params[:splat].first.is_i?
    randomizer.sample(params[:splat].first.to_i).join("\n")
  else
    haml :info
  end
end

class String
    def is_i?
       !!(self =~ /^[-+]?[0-9]+$/)
    end
end