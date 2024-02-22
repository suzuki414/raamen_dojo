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

  def self.search_for(content, method)
    if method == 'perfect'
      RamenNoodle.where(title: content)
    elsif method == 'forward'
      RamenNoodle.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      RamenNoodle.where('title LIKE ?', '%' + content)
    else
      RamenNoodle.where('title LIKE ?', '%' + content + '%')
    end
  end

  # 投稿一覧画面(ソート機能)
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :average_rating_count, -> {order(average_rating: :desc, created_at: :desc)}
  scope :favorite_count, -> {order(favorite: :desc, created_at: :desc)}

  # いいね数を取得し、降順に並べ替える(いいね数が0も含める)
  def self.order_by_favorite_count
    left_joins(:favorites).group(:id).order('COUNT(favorites.id) DESC')
  end

  private

  def post_image_attached
    errors.add(:post_image, :blank, message: "画像が添付されていません") unless post_image.attached?
  end
end
