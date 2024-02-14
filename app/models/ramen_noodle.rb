class RamenNoodle < ApplicationRecord
  belongs_to :member
  has_many :favorites, dependent: :destroy
  has_many :ramen_noodle_comments, dependent: :destroy
  has_many :ramen_noodle_tags, dependent: :destroy
  has_many :tags, through: :ramen_noodle_tags

  has_one_attached :post_image

  validate :post_image_attached
  validates :title, presence: true
  validates :description, presence: true
  validates :recipe, presence: true
  validates :taste_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :cook_time_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :process_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :difficulty_rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end
  
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

  private

  def post_image_attached
    errors.add(:post_image, :blank, message: "画像が添付されていません") unless post_image.attached?
  end
end
