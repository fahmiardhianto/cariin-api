class Berniaga
  require 'open-uri'
  require 'nokogiri'

  def get_cid(category)
    case category
    when 'mobil'
      "Mobil-1020?q="
    when 'motor'
      "Sepeda+motor-1040?q="
    when 'properti'
      "Properti-2000?q="
    when 'keperluan+pribadi'
      "Perlengkapan+rumah-4000?q="
    when 'elektronik+dan+gadget'
      "Elektronik-3000?q="
    else
      ""
    end
  end

  def generate_link(product,category)
    cat = get_cid(category)
    berniaga_url = "http://www.berniaga.com/DI+Yogyakarta/#{cat}product"
    search_products(berniaga_url)
  end

  def search_products(url)
    doc = Nokogiri::HTML(open(url))
    products = Array.new
    doc.css(".lazy-load").each do |item|
      p = Product.new
      p.set_name(item.at_css(".ct-text p").text)
      p.set_price(item.at_css(".list-ad-price").text.delete(' '))
      # p.set_location(item.at_css(".pos-date-loc div").text)
      p.set_url(item.css(".ct-text a").map { |link| link['href']})
      p.set_shop("berniaga.com")
      products << p
    end
    products
  end

end
