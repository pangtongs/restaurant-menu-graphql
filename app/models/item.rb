class Item < ApplicationRecord
  has_many :section_items
  has_many :sections, through: :section_items
  has_many :modifiers
  has_many :item_modifier_groups
  has_many :modifier_groups, through: :item_modifier_groups

  validates :item_type, presence: true, inclusion: { in: ['Product', 'Component'] }
  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
