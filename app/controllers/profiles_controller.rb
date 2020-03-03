class ProfilesController < ApplicationController
  def index
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
   if current_user.update(strong_params)
      redirect_to profile_path(current_user)
    else
      render :edit
   end
  end

  private

  def strong_params
    params.require(:user).permit(:username, :photo)
  end
end
