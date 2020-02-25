class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show]
  def index

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

  end

  def destroy
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
