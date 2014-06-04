class ApplicationController < ActionController::API
  include Crawler

  def index
    product = params[:product]
    category = params[:category]
    location = params[:location]

    render json: search_product(product, location)
  end
end
