class Challenge < ApplicationRecord
  has_one :recipe
  has_many :challenge_ingredients, dependent: :destroy
  has_many :ingredients, through: :challenge_ingredients

  belongs_to :challenger, class_name: 'Player', foreign_key: 'challenger_id'
  belongs_to :opponent, class_name: 'Player', foreign_key: 'opponent_id'
  # belongs_to :player

  # has_one :player, as: :challenger
  # has_one :player, as: :opponent

  def self.build!(challenger_user, opponent_user, attributes = {})
    challenger = Player.create!(user: challenger_user, is_owner: true)
    opponent = Player.create!(user: opponent_user, is_owner: false)
    ingredients = []
    ingredients << attributes[:protein]
    ingredients << attributes[:grain]
    ingredients << attributes[:dairy]
    ingredients << attributes[:vegetable]
    attributes.delete(:protein)
    attributes.delete(:grain)
    attributes.delete(:dairy)
    attributes.delete(:vegetable)
    attributes[:challenger] = challenger
    attributes[:opponent] = opponent
    boolean = Challenge.create!(attributes)
    if attributes[:mode] == 'creative'
      ingredients.each do |ingredient|
        ChallengeIngredient.create!(challenge: Challenge.all.last, ingredient: ingredient)
      end
    end
    boolean
  end

  def players
    [self.challenger, self.opponent]
  end

  def has_he_voted?(user)
    first_vote = challenger.votes.index { |v| v.user == user }
    if first_vote.nil?
      first_vote = opponent.votes.index { |v| v.user == user }
    end
    !first_vote.nil?
    # if this challenger's votes has one from the user, set voted to true
    # if this opponent's votes has one from the user, set voted to true
  end

  def completed?
    self.challenger.photo.attached? && self.opponent.photo.attached?
  end

  def self.all_completed
    Challenge.all.select do |challenge|
      challenge.completed?
    end
  end

  def vote_count
    self.challenger.votes.count + self.opponent.votes.count
  end

  def winner
    if self.challenger.votes.count > self.opponent.votes.count
      self.challenger.user
    elsif self.challenger.votes.count < self.opponent.votes.count
      self.opponent.user
    end
  end
end
