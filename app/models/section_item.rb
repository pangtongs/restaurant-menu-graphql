class SectionItem < ApplicationRecord
  belongs_to :section
  belongs_to :item

  validates :display_order, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
