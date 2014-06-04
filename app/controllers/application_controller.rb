class ApplicationController < ActionController::API
  # include Crawler
  # include OlxScraper

  def index
    product = params[:product]
    category = params[:category]
    location = params[:location]

    olx = Olx.new
    berniaga = Berniaga.new
    kaskus = Kaskus.new

    products = [olx.generate_link(product, category, location), kaskus.generate_link(product)]
    products.flatten!
    products.sort_by! do |product|
      product.name
    end
    # render json: berniaga.generate_link(product, category, location)
    # render json: olx.generate_link(product, category, location)
    # render json: kaskus.generate_link(product)
    render json: products
  end
end
