class ApplicationController < ActionController::API
  # include Crawler
  # include OlxScraper
  def index
    render 'layouts/index'
  end

  def fetch
    name = params[:name]
    name.gsub!(' ', '+')
    category = params[:category]
    category.gsub!(' ', '+') if category 
    location = params[:location]

    olx = Olx.new
    berniaga = Berniaga.new
    kaskus = Kaskus.new

    products = [olx.generate_link(name, category, location), kaskus.generate_link(name)]
    # products = [olx.generate_link(name, category, location), kaskus.generate_link(name), berniaga.generate_link(name, category)]
    products.flatten!
    products.sort_by! do |product|
      product.name
    end
    # render json: berniaga.generate_link(product, category, location)
    # render json: olx.generate_link(product, category, location)
    # render json: kaskus.generate_link(product)
    render json: products
    # render name
  end
end
