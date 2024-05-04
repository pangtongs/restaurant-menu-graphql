class MenuSection < ApplicationRecord
  belongs_to :menu
  belongs_to :section

  validates :display_order, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
