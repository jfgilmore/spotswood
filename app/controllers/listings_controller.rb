class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only: %i[show edit update destroy]

  def index
    @listing = Listing.all
  end

  def show; end

  def new
    @listing = Listing.new
  end

  def edit; end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  # PATCH/PUT /listings/1
  def update
    @listing.assign_attributes(listing_params)

    if @listing.changed?
      if @listing.update(listing_params)
        redirect_to @listing
      else
        render :edit
      end
    else
      redirect_to @listing
    end
  end

  # DELETE /listings/1
  def destroy
    @listing.destroy
    redirect_to listings_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:name, :time, :location, :why, :cost,
                                    :summary, :description)
  end
end
