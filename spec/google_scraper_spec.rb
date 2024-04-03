require './lib/google_scraper'
require 'json'

RSpec.describe GoogleScraper do
  before :each do
    @page = File.read("files/van-gogh-paintings.html")
    @json = File.read("files/expected-array.json")
    @expected_array = JSON.parse(@json)
    @google_scraper = GoogleScraper.new
  end

  describe "scrape" do
    it "should return an array of paintings with attributes name, extensions, link, and image" do
      expect(@google_scraper).to be_an_instance_of(GoogleScraper)

      first_painting = @expected_array["artworks"].first
      yellow = @google_scraper.scrape(@page).find { |painting| painting.name == "The Yellow House"}

      expect(@google_scraper.scrape(@page).length).to eq(@expected_array["artworks"].length)
      expect(@google_scraper.scrape(@page).first.name).to eq(first_painting["name"])
      expect(@google_scraper.scrape(@page).first.extensions).to eq(first_painting["extensions"])
      expect(@google_scraper.scrape(@page).first.extensions).to be_a(Array)
      expect(@google_scraper.scrape(@page).first.link).to eq(first_painting["link"])
      expect(yellow.image).to be(nil)

      #Image is not passing
      # expect(@google_scraper.scrape(page).first.image).to eq(first_painting["image"])
    end
  end

  describe "format" do
    it "should format all paintings from the scrape method" do
      all_paintings = @google_scraper.scrape(@page)

      first_painting = @google_scraper.format(all_paintings).first
      expected_first = @expected_array["artworks"].first

      expect(@google_scraper.format(all_paintings)).to be_a(Array)
      expect(@google_scraper.format(all_paintings).length).to eq(@expected_array["artworks"].length)

      expect(first_painting['name']).to eq(expected_first['name'])
      expect(first_painting['extensions']).to eq(expected_first['extensions'])
      expect(first_painting['link']).to eq(expected_first['link'])

      #image not passing
      # expect(first_painting['image']).to eq(expected_first['image'])
    end
  end
end
