# Require the bundler gem and then call Bundler.require to load in all gems
# listed in Gemfile.
require 'bundler'
require 'csv'
Bundler.require

# set up hash to keep probabilities in
data = Hash.new

# load data csv row by row
f = CSV.foreach("randgen-data.csv") do |row|
  # add each row to hash
  data[row[0]] = row[1].to_f
end

# set up weighted randomizer with hash
randomizer = WeightedRandomizer.new(data)

# serve pages
get '/*' do
  # if it's '/#integer'
  if params[:splat].first.is_i?
    # get #integer random numbers
    @out = randomizer.sample(params[:splat].first.to_i)
  else
    # otherwise get 5 random numbers
    @out = randomizer.sample(5)
  end
  # and serve the page
  haml :info
end

# monkeypatch string
class String
    # with method to check for integerness
    def is_i?
       !!(self =~ /^[-+]?[0-9]+$/)
    end
end