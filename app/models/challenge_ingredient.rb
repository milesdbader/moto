class ChallengeIngredient < ApplicationRecord
  belongs_to :challenge
  belongs_to :ingredient
end
