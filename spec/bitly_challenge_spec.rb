require './lib/bitly_challenge'

RSpec.describe 'Challenge' do
  before(:each) do
    @rows = []
    CSV.foreach('encodes.csv', headers: true, converters: :all) do |row|
    @rows << row.to_hash

    @file = File.read('decodes.json')
    @data_hash = JSON.parse(@file)
    @hash = Hash.new(0)
    @data_hash.each do |key, _value|
      @rows.each do |row|
        next unless row['hash'] == key['bitlink'][-7..-1]
      @hash[row['long_url']] += 1 if key['timestamp'][0..3] == '2021'
      end
    end
  end
  @hash = @hash.sort_by { |_k, v| v }.reverse.to_h
  @array = []
  @hash.map do |key, value|
    @array << { key => value }
  end
end
  it 'converts encodes.csv' do
    expect(@rows.class).to eq(Array)
    expect(@rows.length).to eq(6)
    expect(@rows.first.values).to include('https://google.com/')
  end

  it 'creates a hash' do
    expect(@array).to be_an(Array)
    expect(@array.length).to eq(6)
  end
end
