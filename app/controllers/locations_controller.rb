class LocationsController < ApplicationController

  def index
    @locations = Location.all
    render json: {locations: @locations}
  end

  def create
    @location = Location.create(location_params)
    render json: @location
  end

  def update
  end

  def destroy
  end

  private
  def location_params
    params.require(:location).permit(:category, :longitude, :latitude, :address, :author)
  end

end
