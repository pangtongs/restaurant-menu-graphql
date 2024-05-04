class ModifierGroup < ApplicationRecord
  has_many :modifiers
  has_one :item_modifier_group
  has_one :item, through: :item_modifier_group

  validates :identifier, presence: true, uniqueness: true
  validates :label, presence: true
  validates :selection_required_min, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :selection_required_max, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
