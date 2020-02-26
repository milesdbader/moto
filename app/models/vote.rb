class Vote < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :player, dependent: :destroy
end
