class Api::BreweriesController < ActionController::API
  def index
    @breweries = Brewery.all
    render json: @breweries.as_json
  end

end
