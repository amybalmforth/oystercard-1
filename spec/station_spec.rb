require "station"


describe Station do



  it "checks if station has a name" do
    station = Station.new("bank", 1)
    expect(station.name).to eq "bank"
  end

  it "checks if station has a zone" do
    station = Station.new("bank", 1)
    expect(station.zone).to eq 1
  end







end
