class Tag < ApplicationRecord
  has_many :ramen_noodle_tags, dependent: :destroy
  has_many :ramen_noodles, through: :ramen_noodle_tags

  validates :name, presence:true
end
