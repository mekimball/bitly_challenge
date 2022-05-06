require 'csv'
require 'json'
rows = []
CSV.foreach('encodes.csv', headers: true, converters: :all) do |row|
  rows << row.to_hash
end

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

test = hash.sort_by{|k, v| v}.reverse.to_h
array = []
test.each do |key, value|
  new = {key => value}
  array << new
end
pp array