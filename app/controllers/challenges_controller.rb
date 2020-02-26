class ChallengesController < ApplicationController
  def index

  end

  def new
    # @challenge = Challenge.new
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

  private

  def challenge_params
    params.require(:challenge).permit(:mode)
  end
end
