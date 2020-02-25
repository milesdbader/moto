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
    render json: {ok: true, user: opponent}
  end
end
