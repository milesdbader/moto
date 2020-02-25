class ChallengesController < ApplicationController
  def index

  end

  def new
    # @challenge = Challenge.new
  end

  def show
  end

  def create
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
    params.require(:challenge).permit(:challenger, :opponent, :mode)
  end
end
