class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all_in_ascending_order
  end

  def new
    @brewery = Brewery.new
  end

  def create
    @brewery = Brewery.new(brewery_params)
    if @brewery.save
      flash.notice = "Successfully added new Brewery."
      redirect_to breweries_path
    else
      flash.now.alert = "There was an error adding a brewery."
      render :new
    end
  end

  private

  def brewery_params
    params.require(:brewery).permit(:name)
  end
end
