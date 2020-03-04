class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show destroy accepted]
  before_action :set_cache_headers, only: :index

  def index
    @user = current_user
    @active_challenges = current_user.active_challenges.reverse
    @pending_challenges = current_user.pending_challenges.reverse
  end

  def new
    @user = current_user
    randomize_ingredients
    reciper
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
    if Challenge.build!(@challenger, @opponent, mode: params[:mode], recipe_id: @recipe, protein: @protein, dairy: @dairy, grain: @grain, vegetable: @vegetable, accepted: false)
      redirect_to challenges_path
    else
      render :new
    end
  end

  def accepted
    @challenge.accepted = true
    @challenge.expiration = Time.now + 259200
    if @challenge.save
      redirect_to root_path
    end
  end

  def destroy
  end

  def take_user
    opponent = User.find_by(username: params['q'])
    if opponent.blank?
      render json: {ok: false}
    else
      opponent = opponent.format_for_challenge
      render json: {ok: true, user: opponent}
    end
  end




  def serve
    @challenge = Challenge.find(params[:challenge_id])

    if @challenge.challenger.user.id == current_user.id
      @player = @challenge.challenger
    else
      @player = @challenge.opponent
    end
  end

  def reciper
    @recipe = Recipe.all.sample
  end

  def destroy
    @challenge.destroy
    redirect_to challenges_path
  end

  def randomizer
    randomize_ingredients
  end

  def search_users
    opponents = User.where('username ILIKE ?', "#{params['q']}%")
    if opponents.empty?
      render json: {ok: false}
    else
      render json: {ok: true, users: opponents}
    end

  end
  private


  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def randomize_ingredients
    @protein = Ingredient.where(category: 'protein').sample
    @grain = Ingredient.all.where(category: 'grain').sample
    @vegetable = Ingredient.all.where(category: 'vegetable').sample
    @dairy = Ingredient.all.where(category: 'dairy').sample
  end
end
