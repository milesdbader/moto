class PlayersController < ApplicationController
  before_action :set_player, only: %i[edit update]
  before_action :set_challenge, only: %i[edit update]

  def create
  end

  def edit
  end

  def update
    # raise
    if @player.update(player_params)
      redirect_to new_challenge_vote_path(@challenge)
    else
      render :new
    end

    if @challenge.completed?
      @challenge.voting_end = Time.now + 259200
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def set_challenge
    @challenge = @player.challenge
  end

  def player_params
    params.require(:player).permit(:caption, :title, :photo)
  end
end
