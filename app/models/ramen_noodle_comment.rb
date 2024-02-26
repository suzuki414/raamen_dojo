class RamenNoodleComment < ApplicationRecord
  belongs_to :member
  belongs_to :ramen_noodle

  validates :comment, presence: true, length: { in: 1..50 }
end
