class Tag < ApplicationRecord
  has_many :ramen_noodle_tags, dependent: :destroy
  has_many :ramen_noodles, through: :ramen_noodle_tags

  def self.search_for(content, method)
    if method == 'perfect'
      Tag.where(name: content)
    elsif method == 'forward'
      Tag.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Tag.where('name LIKE ?', '%' + content)
    else
      Tag.where('name LIKE ?', '%' + content + '%')
    end
  end

end
