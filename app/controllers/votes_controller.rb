class VotesController < ApplicationController
  before_action :set_challenge, only: %i[new create]
  def create
    @challenger = @challenge.challenger
    @opponent = @challenge.opponent
    @vote = Vote.new(player: Player.find(params[:player]), user: current_user)
    @vote.save
    # redirect_to new_challenge_vote(current_user.next_votable_challenge.id)
    @has_another_vote = current_user.next_votable_challenge
    if @has_another_vote
      @next_url = new_challenge_vote_path(current_user.next_votable_challenge)
      respond_to do |format|
        format.html {
          redirect_to @next_url
        }
        format.js
      end
    else
      @next_url = challenges_path
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  def index
  end

  def new
    @vote = Vote.new
    @challenger = @challenge.challenger
    @opponent = @challenge.opponent
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def player_params
    params.require(:player).permit(:caption, :title, :photo)
  end
end
