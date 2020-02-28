class Player < ApplicationRecord
  belongs_to :user, class_name: 'User'
  # has_one :challenge
  has_many :votes, dependent: :destroy
  has_one_attached :photo

  def challenge
    found = Challenge.find_by(challenger: self)
    return found unless found.nil?
    return Challenge.find_by(opponent: self)
  end
end
