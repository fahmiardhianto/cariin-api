module Crawler
  require 'nokogiri'
  require 'open-uri'

  def generate_link(product, location)
    olx = "http://www.olx.co.id/halaman/lokasi/#{location}/cgid/92/mencari/#{product}/di/elektronik-gadget/cpi/92/search"
    return olx
  end

  def search_product(product, location)
    url = generate_link(product, location)
    doc = Nokogiri::HTML(open(url))
    products = Array.new
    doc.css(".listingbox").each do |item|
      p = Product.new
      p.set_name(item.at_css(".ikl-title").text)
      p.set_price(item.at_css(".price").text.delete(' '))
      p.set_location(item.at_css(".locprop").text)
      p.set_url(item.css(".ikl-box a").map { |link| link['href']})
      products << p
    end
    products
  end

end
