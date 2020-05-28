# frozen_string_literal: true

class InteractionsController < ApplicationController
  before_action :set_interaction, only: %i[edit update]
  load_and_authorize_resource

  # Generates new Interaction from Interaction Model
  # GET /interaction/new -> is a partial of show Listing
  def new
    @interaction = Interaction.new
  end

  # POST /interaction
  def create
    if current_user == nil
      flash.alert = "Awesome you want to: #{
        @interaction.user_action.to_s.humanize
      }; you need to log in first"
      return redirect_to new_user_session_path
    end

    @interaction = current_user.interactions.new(interaction_params)

    flash.alert = if @interaction.save
                    "Awesome your going to: #{
                      @interaction.user_action.to_s.humanize
                    }"
                  else
                    'Something went wrong'
                  end
    redirect_to listing_url @interaction.listing_id
  end

  # PATCH /interaction/:id
  # View is a partial of show Listing
  def edit; end

  # Update a interaction only if changes were made
  def update
    @interaction.assign_attributes(interaction_params)
    return unless @interaction.changed?

    flash.alert = if @interaction.update(interaction_params)
                    "Awesome your going to: #{
                      @interaction.user_action.to_s.humanize
                    }"
                  else
                    'Something went wrong'
                  end
    redirect_to listing_url @interaction.listing_id
  end

  private

  # Search Interactions in db, returns first match on id(unique).
  def set_interaction
    @interaction = Interaction.find(params[:id])
  end

  # Only allow the white list of parameters through.
  def interaction_params
    params.require(:interaction).permit(:listing_id, :user_action)
  end
end
