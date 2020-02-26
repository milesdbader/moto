class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show destroy]
  
  def index
    @user = current_user
    @active_challenges = current_user.active_challenges
    @pending_challenges = current_user.pending_challenges
  end

  def new
  end

  def show
  end

  def create
    @opponent = User.find(params[:opponent])
    @challenger = User.find(params[:challenger])
    @recipe = nil
    @protein = Ingredient.find(params[:protein])
    @vegetable = Ingredient.find(params[:vegetable])
    @grain = Ingredient.find(params[:grain])
    @dairy = Ingredient.find(params[:dairy])
    if params[:mode] == 'classic'
      @recipe = Recipe.find(params[:recipe]).id
    end
    if Challenge.build!(@opponent, @challenger, mode: params[:mode], recipe_id: @recipe, protein: @protein, dairy: @dairy, grain: @grain, vegetable: @vegetable)
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

    if @challenge.challenger.user.id == current_user.id
      @player = Player.find(current_user.id)
    else
      @player = Player.find(@challenge.opponent.user.id)
    end
  end


  def destroy
    @challenge.destroy
    redirect_to challenges_path
  end
  
  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end
end
