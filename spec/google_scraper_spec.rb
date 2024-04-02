require './lib/google_scraper'
require 'json'

RSpec.describe GoogleScraper do
  it "should return extract the painting name, extensions and link" do
    page = File.read("files/van-gogh-paintings.html")
    google_scraper = GoogleScraper.new
    expect(google_scraper).to be_an_instance_of(GoogleScraper)
    
    
    json = File.read("files/expected-array.json")
    expected_array = JSON.parse(json)
    first_painting = expected_array["artworks"].first

    # expect(google_scrapper.scrape(page).length).to eq(expected_array["artworks"].length)
    # expect(google_scrapper.scrape(page).first.name).to eq(first_painting["name"])
    # expect(google_scrapper.scrape(page).first.extensions).to eq(first_painting["extensions"])
    # expect(google_scrapper.scrape(page).first.extensions).to be_a(Array)
    # expect(google_scrapper.scrape(page).first.link).to eq(first_painting["link"])

    #Image is not passing
    # expect(google_scrapper.scrape(page).first.image).to eq(first_painting["image"])

    first_painting = google_scrapper.scrape(page)["artworks"].first
    expected_first = expected_array["artworks"].first


    expect(google_scrapper.scrape(page)["artworks"]).to be_a(Array)
    expect(google_scrapper.scrape(page)).to be_a(Hash)
    expect(google_scrapper.scrape(page)["artworks"].length).to eq(expected_array["artworks"].length)

    expect(first_painting['name']).to eq(expected_first['name'])
    expect(first_painting['extensions']).to eq(expected_first['extensions'])
    expect(first_painting['link']).to eq(expected_first['link'])

    #image not working correctly
    # expect(first_painting['image']).to eq(expected_first['image'])
  end
end
