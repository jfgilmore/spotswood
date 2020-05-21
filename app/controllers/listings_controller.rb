# frozen_string_literal: true

class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy]
  load_and_authorize_resource

  # All queries only allow search of current listings, past listings should only
  # be visible to their owners.
  def index
    @user = current_user
    @listings =
      if params[:search]
        # Returns listings search on name & summary, defined in Model.
        Listing.with_attached_images.eager_load(interactions: :listing).search(params).order(:at_time).where('listings.at_time > ?', Time.zone.now)
      elsif params[:category]
        Listing.filter_by_category(params[:category]).order(:at_time).where('at_time > ?', Time.zone.now)
      else
        # Load all listings with a future date sort by ascending date
        # Load their images along with them for display.
        @listings = Listing.eager_load(:interactions).with_attached_images.order(:at_time).where('at_time > ?', Time.zone.now)
        # Highlighting of interacted with functions is causing more queries from
        # the view. I will consider revising this function.
      end
  end

  # Article.where("published_at >= ?", Time.current)

  def show; end

  # POST /listings --Creates a listing from the Listing ActiveModel
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
  # Search Listings in db, returns first match on id(unique). Returns user,
  # category, and interactions.
  def set_listing
    @listing = Listing.with_attached_images.eager_load(
      :user, :category,
      interactions: :listing
    ).find(params[:id])
  end

  # Only allow the white list of parameters through.
  def listing_params
    params.require(:listing).permit(:name, :at_time, :location, :why, :cost,
                                    :summary, :description, :updated_at,
                                    :category_id, :search, images: [])
  end
end
