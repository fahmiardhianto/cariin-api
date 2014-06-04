class Product
  attr_accessor :name, :item_url, :price, :location

  def set_name(name)
    self.name = name
  end

  def set_price(price)
    self.price = price
  end

  def set_location(location)
    self.location = location
  end

  def set_url(url)
    self.item_url = url
  end
end
