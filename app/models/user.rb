class User < ApplicationRecord
  has_one_attached :photo
  has_many :players, dependent: :destroy
  has_many :challenges, through: :players
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def challenges
    # Challenge.joins(
    #   'INNER JOIN players p ON challenges.challenger_id = p.id
    #   OR challenges.opponent_id = p.id
    #   INNER JOIN users u ON p.user_id = u.id')
    #   .where('u.id = ?', id)
    Challenge.distinct.joins(
      'LEFT JOIN players challenger
        ON challenges.challenger_id = challenger.id
      LEFT JOIN players opponent
        ON challenges.opponent_id = opponent.id
      INNER JOIN users
        ON challenger.user_id = users.id
        OR opponent.user_id = users.id'
      ).where(
        'challenger.user_id = :user_id OR opponent.user_id = :user_id',
        user_id: id
      )
  end

  # Challenges that have been accepted, but not completed
  def active_challenges
    # A challenge is active when:
    # - one/both images is not present AND
    # - expiration is not null and is in the future AND
    # - accepted = true
    challenges.where(
      '(challenger.image_url IS NULL OR opponent.image_url IS NULL)
      AND (challenges.expiration IS NOT NULL AND challenges.expiration > NOW())
      AND challenges.accepted = true'
    ).select { |challenge| !(challenge.challenger.photo.attached? && challenge.opponent.photo.attached?)}

  end

  # Challenges that have not been accepted
  def pending_challenges
    challenges.where(accepted: false)
  end
end
