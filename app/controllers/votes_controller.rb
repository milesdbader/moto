class VotesController < ApplicationController
  before_action :set_challenge, only: %i[new]
  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.save
    # redirect_to new_challenge_vote(current_user.next_votable_challenge.id)
    redirect_to root
  end

  def index
  end

  def new
    @vote = Vote.new
  end

  private

  def vote_params
    params.require(:vote).permit(:player)
  end

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def player_params
    params.require(:player).permit(:caption, :title, :photo)
  end
end
