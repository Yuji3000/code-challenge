require './lib/google_scrapper'
require 'json'

RSpec.describe GoogleScrapper do
  it "should return extract the painting name, extensions and link" do
    page = File.read("files/van-gogh-paintings.html")
    google_scrapper = GoogleScrapper.new
    expect(google_scrapper).to be_an_instance_of(GoogleScrapper)
    
    
    json = File.read("files/expected-array.json")
    expected_array = JSON.parse(json)
    first_painting = expected_array["artworks"].first
    
    expect(google_scrapper.scrape(page).length).to eq(expected_array["artworks"].length)
    expect(google_scrapper.scrape(page).first.name).to eq(first_painting["name"])
    expect(google_scrapper.scrape(page).first.extensions).to eq(first_painting["extensions"])
    expect(google_scrapper.scrape(page).first.extensions).to be_a(Array)
    expect(google_scrapper.scrape(page).first.link).to eq(first_painting["link"])
  end
end
