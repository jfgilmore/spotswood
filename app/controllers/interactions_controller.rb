class InteractionsController < ApplicationController
  before_action :set_interaction, only: %i[show edit update]
  load_and_authorize_resource

  def new
    @interaction = Interaction.new
  end

  def create
    @interaction = current_user.interactions.new(interaction_params)

    if @interaction.save
      flash.alert = "Awesome your going to: #{@interaction.user_action.to_s.humanize }"
      redirect_to listing_url @interaction.listing_id
    else
      flash.alert = 'Something went wrong'
      redirect_to listing_url @interaction.listing_id
    end
  end

  def edit; end

  # Update a interaction only if changes were made
  def update
    @interaction.assign_attributes(interaction_params)

    if @interaction.changed?
      if @interaction.update(interaction_params)
        flash.alert = "Awesome your going to: #{@interaction.user_action.to_s.humanize }"
        redirect_to listing_url @interaction.listing_id
      else
        flash.alert = 'Something went wrong'
        redirect_to listing_url @interaction.listing_id
      end
    else
      flash.alert = '👍'
    end
  end

  private

  def set_interaction
    @interaction = Interaction.find(params[:id])
  end

  def interaction_params
    params.require(:interaction).permit(:listing_id, :user_action)
  end
end
