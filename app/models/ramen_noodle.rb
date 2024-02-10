class RamenNoodle < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :ramen_noodle_comments, dependent: :destroy
  has_many :ramen_noodle_tags, dependent: :destroy

  has_one_attached :post_image

  validates :average_rating, numericality: {
  less_than_or_equal_to: 5,
  greater_than_or_equal_to: 1}, presence: true

end
