class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :ramen_noodle

  validates :member_id, uniqueness: {scope: :ramen_noodle_id}
end
