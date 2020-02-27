class Player < ApplicationRecord
  belongs_to :user, class_name: 'User'
  # has_one :challenge
  has_many :votes
  has_one_attached :photo

  def challenge
    found = Challenge.find_by(challenger: self)
    Challenge.find_by(opponent: self) if found.nil?
  end
end
