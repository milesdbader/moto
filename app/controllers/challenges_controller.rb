class ChallengesController < ApplicationController
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

  def destroy
  end
end
