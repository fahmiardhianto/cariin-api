module Crawler
  require 'nokogiri'
  require 'open-uri'

  def link(product)
    olx = "http://www.olx.co.id/halaman/cgid/92/mencari/#{product}/di/elektronik-gadget/cpi/92/search"
    return olx
  end

  def search(product)
    url = link(product)
    doc = Nokogiri::HTML(open(url))
    products = Array.new
    doc.css(".listingbox").each do |item|
      products << item.at_css(".ikl-title").text
    end
    products
  end

end
