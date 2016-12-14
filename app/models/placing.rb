class Placing < ApplicationRecord
  validates :user_id, :tournament_id, :placement, presence: true

  belongs_to :user
  belongs_to :tournament
end
