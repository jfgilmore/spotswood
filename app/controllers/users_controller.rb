class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def edit
  end

  # Update a user only if changes were made
  def update
    @user = resource

    if @user.changed?
      if @user.update(user_params)
        redirect_to users_path, notice: "#{@user.name} was successfully updated."
      else
        render :edit
      end
      redirect_to users_path
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "#{@user.name} was successfully deleted."
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end
