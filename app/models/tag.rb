class Tag < ApplicationRecord
  has_many :ramen_noodle_tags, dependent: :destroy
end
