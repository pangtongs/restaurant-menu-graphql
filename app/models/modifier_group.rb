class ModifierGroup < ApplicationRecord
  has_many :modifiers
  has_many :item_modifier_groups
  has_many :items, through: :item_modifier_groups

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :selection_required_min, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :selection_required_max, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
