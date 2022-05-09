require 'csv'
require 'json'
#converts encodes to a hash
rows = []
CSV.foreach('encodes.csv', headers: true, converters: :all) do |row|
  rows << row.to_hash
end

#opens and parses the decodes file into JSON
file = File.read('decodes.json')
data_hash = JSON.parse(file)
hash = Hash.new(0)
data_hash.each do |key, value|
  rows.each do |row|
    if row['hash'] == key['bitlink'][-7..-1]
      if key['timestamp'][0..3] == '2021'
        hash[row['long_url']] += 1
      end
    end
  end
end
#combines the two into a single JSON  
hash = hash.sort_by { |_k, v| v }.reverse.to_h
array = []
hash.map do |key, value|
  array << { key => value }
end
pp array