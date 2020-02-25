class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show]
  def index
    @active_challenges = current_user.active_challenges
    @pending_challenges = current_user.pending_challenges
  end

  def new
  end

  def show
  end

  def create
  end

  def accepted?
  end

  def serve
    @challenge = Challenge.find(params[:challenge_id])
    @player = Player.find(current_user.id)
  end

  def destroy
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # def challenge_params
  #   params.require(:challenge).permit(:content, :photo)
  # end
end
