class VotesController < ApplicationController
  before_action :set_challenge, only: %i[new]
  def create
  end

  def index
  end

  def new
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def player_params
    params.require(:player).permit(:caption, :title, :photo)
  end
end
