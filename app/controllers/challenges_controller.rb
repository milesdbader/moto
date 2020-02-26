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
    @challenge = Challenge.new
    @opponent = User.find(params[:opponent])
    @challenger = User.find(params[:challenger])
    @challenge.build!(@opponent, @challenger, challenge_params)
    if @challenge.save
      redirect_to challenges_path
    else
      render :new
    end
  end

  def accepted?
  end

  def destroy
  end

  def take_user
    opponent = User.where(username: params['q'])
    if opponent.empty?
      render json: {ok: false}
    else
      render json: {ok: true, user: opponent}
    end
  end

  def serve
    @challenge = Challenge.find(params[:challenge_id])
    @player = Player.find(current_user.id)
  end

  private


  def challenge_params
    params.require(:challenge).permit(:mode)
  end

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  # def challenge_params
  #   params.require(:challenge).permit(:content, :photo)
  # end
end
