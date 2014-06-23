class Kaskus
  require 'open-uri'
  require 'nokogiri'

  def generate_link(product)
    kaskus_url = "http://www.kaskus.co.id/search/fjb?f=fjb&q=#{product}"
    search_products(kaskus_url)
  end

  def search_products(url)
    doc = Nokogiri::HTML(open(url))
    products = Array.new
    doc.css(".post").each do |item|
      p = Product.new
      p.set_name(item.at_css(".post-title").text)
      # p.set_price(item.at_css(".price").text.delete(' '))
      # p.set_price('')
      p.set_location(doc.css('.adr').at_css(".locality").text)
      p.set_url(item.css(".post-title a").map { |link| link['href']})
      p.set_shop('Kaskus')
      products << p
    end
    products
  end

end
