class Tag < ApplicationRecord
  has_many :ramen_noodle_tags, dependent: :destroy
  has_many :ramen_noodles, through: :ramen_noodle_tags

  validates :name, presence:true

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

end
