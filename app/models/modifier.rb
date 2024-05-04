class Modifier < ApplicationRecord
  belongs_to :item
  belongs_to :modifier_group

  validates :display_order, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :default_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
