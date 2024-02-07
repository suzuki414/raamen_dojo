class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :ramen_noodle
end
