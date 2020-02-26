class PlayersController < ApplicationController
  before_action :set_challenge, only: %i[show edit update]

  def create
  end

  def edit
    raise
  end

  def update
    if @challenge.challenger.user.id == current_user.id
      @player = Player.find(current_user.id)

    else
      @player = Player.find(@challenge.opponent.user.id)
    end

    if @player.update(player_params)
      @player.save!
      # raise
      redirect_to new_challenge_vote_path(@challenge)
    else
      render :new
    end

  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:caption, :title, :photo)
  end
end
