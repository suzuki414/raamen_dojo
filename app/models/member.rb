class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  GUEST_MEMBER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "ゲスト会員"
      member.nickname = "ゲスト"
      member.comment = "ゲスト会員です"
    end
  end

  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end

  has_many :ramen_noodles, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_ramen_noodles, through: :favorites, source: :ramen_noodle
  has_many :ramen_noodle_comments, dependent: :destroy
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, presence: true
  validates :nickname, presence: true
  validates :comment, presence: true

  # 指定したユーザーをフォローする
  def follow(member)
    # byebug
    active_relationships.create(followed_id: member.id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(member)
    active_relationships.find_by(followed_id: member.id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(member)
    followings.include?(member)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Member.where(nickname: content)
    elsif method == 'forward'
      Member.where('nickname LIKE ?', content + '%')
    elsif method == 'backward'
      Member.where('nickname LIKE ?', '%' + content)
    else
      Member.where('nickname LIKE ?', '%' + content + '%')
    end
  end

  # 投稿一覧画面(ソート機能)
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :followed_count, -> {order(followed: :desc)}
  scope :ramen_noodle_count, -> {order(ramen_noodle: :desc)}
  
  # フォロー、フォロワー一覧画面(ソート機能)
  # scope :following, -> {order(followed: :desc)}
  # scope :follower, -> {order(follower: :desc)}

  # フォロワー数を取得し、降順に並べ替える(フォロワー数が0も含める)
  def self.order_by_followed_count
    left_joins(:followers).group(:id).order('COUNT(followed_id) DESC')
  end

  # 投稿数を取得し、降順に並べ替える(投稿数が0も含める)
  def self.order_by_ramen_noodle_count
    left_joins(:ramen_noodles).group(:id).order('COUNT(ramen_noodles.id) DESC')
  end

  # プロフィール画像を指定した幅と高さにリサイズして返すためのメソッドです。
  # プロフィール画像が添付されていない場合は、デフォルトの画像を使用して同様のリサイズ処理を行います。
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/No_Image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
