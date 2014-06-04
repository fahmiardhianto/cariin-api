class ApplicationController < ActionController::API
  include Crawler
  def query
    product = params[:product]
    category = params[:category]
    location = params[:location]

    render json: search(product)
  end
end
