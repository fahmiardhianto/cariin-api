class Berniaga
  require 'open-uri'
  require 'nokogiri'

  def get_cid(category)
    case category
    when 'mobil'
      "Mobil+kendaraan+lain-1000?md=gi&f=a"
    # when 'motor'
    #   87
    # when 'properti'
    #   88
    # when 'keperluan pribadi'
    #   98
    # when 'elektronik dan gadget'
    #   92
    end
  end

  def generate_link(product,category,location)
    cat = get_cid(category)
    berniaga_url = "http://www.berniaga.com/#{location}/#{cat}"
    search_products(berniaga_url)
  end

  def search_products(url)
    doc = Nokogiri::HTML(open(url))
    products = Array.new
    doc.css(".ct-text").each do |item|
      p = Product.new
      p.set_name(item.at_css("p").text)
      p.set_price(item.at_css(".list-ad-price").text.delete(' '))
      p.set_location(item.at_css(".pos-date-loc div").text)
      p.set_url(item.css("a").map { |link| link['href']})
      products << p
    end
    products
  end

end
