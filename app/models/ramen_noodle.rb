class RamenNoodle < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :ramen_noodle_comments, dependent: :destroy
  has_many :ramen_noodle_tags, dependent: :destroy

  has_one_attached :post_image

  validate :post_image_attached
  validates :title, presence: true
  validates :description, presence: true
  validates :recipe, presence: true
  validates :taste_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :cook_time_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :process_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :difficulty_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  private

  def post_image_attached
    errors.add(:post_image, :blank, message: "must be attached") unless post_image.attached?
  end
end
