class Player < ApplicationRecord
  belongs_to :user, dependent: :destroy
  # has_one :challenge
  has_many :votes

  def challenge
    found = Challenge.find_by(challenger: self)
    Challenge.find_by(opponent: self) if found.nil?
  end
end