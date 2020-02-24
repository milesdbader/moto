class User < ApplicationRecord
  has_many :players
  has_many :challenges, through: :players
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def challenges
    Challenge.joins(
      'INNER JOIN players p ON challenges.challenger_id = p.id
      OR challenges.opponent_id = p.id
      INNER JOIN users u ON p.user_id = u.id')
      .where('u.id = ?', id)
  end
end
