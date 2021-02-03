require 'station'

describe Station do
  it "knows its station" do
  station = Station.new('Euston', 2)
  expect(station.name).to eq 'Euston'
  end
  it "knows its zone" do
    station = Station.new('Euston', 2)
    expect(station.zone).to eq 2
    end
end