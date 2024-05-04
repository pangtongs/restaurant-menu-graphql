module Mutations
  module ModifierGroup
    class CreateModifierGroup < Mutations::BaseMutation
      argument :item_id, ID, required: true
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :selection_required_max, Integer, required: false
      argument :selection_required_min, Integer, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(item_id:, **attributes)
        item = ::Item.find(item_id)
        modifier_group = ::ModifierGroup.create!(item: item, **attributes)
        { modifier_group: modifier_group }
      end
    end
  end
end
