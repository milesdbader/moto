class Challenge < ApplicationRecord
  has_one :recipe
  has_many :challenge_ingredients
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
    Challenge.create!(attributes)
    if attributes[:mode] == 'creative'
      ingredients.each do |ingredient|
        ChallengeIngredient.create!(challenge: Challenge.all.last, ingredient: ingredient)
      end
    end
  end

  def players
    [self.challenger, self.opponent]
  end
end
