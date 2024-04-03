require 'nokogiri'
require 'base64'


class GoogleScraper
  def initialize
    @base_url = "https://www.google.com"
  end
  
  def scrape(page)
    document = Nokogiri::HTML(page)
    painting = Struct.new(:name, :extensions, :link, :image)

    all_paintings = []
    
    css_paintings = document.css(".MiPcId")

    css_paintings.each do |p|
      name = p.at('a')['aria-label']
      link = @base_url + p.at('a')['href']
      find_extension = [p.at('a')['title'][/\((.*?)\)/, 1]]
      extensions = find_extension.empty? ? nil : find_extension
      image = p.css('img').first['src']

      all_paintings << painting.new(name, extensions, link, image)
    end

    all_paintings
  end

  def format(all_paintings)
    return_hash = {
      "artworks" => [
      ]
    }

    all_paintings.each do |paint|
      one_painting = {
        "name" => paint.name,
        "extensions" => paint.extensions,
        "link" => paint.link,
        "image" => paint.image
      }

      one_painting.delete("extensions") if one_painting["extensions"][0].nil?
      return_hash["artworks"] << one_painting
    end
    return_hash
  end
end