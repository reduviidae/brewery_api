class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all
    render :json => @breweries
  end

  # def create
  #   @brewery = Brewry.create(brewery_params)
  #   if @brewery.save
  #     render json: @brewery
  #   else
  #     render json: { error: `failed to create brewery`}, status: :not_acceptible
  #   end
  # end
  #
  # private
  # def brewery_params
  #   params.require(:brewery).permit(:name, :brewery_type, :street, :city, :state, :postal_code, :country, :longtitude, :latitude, :phone, :website_url)
  # end

end
