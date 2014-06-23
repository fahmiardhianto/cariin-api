class Olx
  require 'open-uri'
  require 'nokogiri'

  def get_cid(category)
    case category
    when 'mobil'
      86
    when 'motor'
      87
    when 'properti'
      88
    when 'keperluan+pribadi'
      98
    when 'elektronik+dan+gadget'
      92
    end
  end

  def generate_link(product, category, location)
    cid = get_cid(category)
    olx_url = "http://www.olx.co.id/halaman/lokasi/#{location}/cgid/#{cid}/mencari/#{product}/di/#{category}/cpi/#{cid}/search"
    search_products(olx_url)
  end

  def search_products(url)
    doc = Nokogiri::HTML(open(url))
    products = Array.new
    doc.css(".listingbox").each do |item|
      p = Product.new
      p.set_name(item.at_css(".ikl-title").text)
      p.set_price(item.at_css(".price").text.delete(' '))
      p.set_location(item.at_css(".locprop").text)
      p.set_url(item.css(".ikl-box a").map { |link| link['href']})
      p.set_image_url(item.css(".fotoimage").map { |link| link['src']})
      p.set_shop('olx.co.id')
      products << p
    end
    products
  end

end
