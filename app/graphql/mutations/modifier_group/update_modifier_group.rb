module Mutations
  module ModifierGroup
    class UpdateModifierGroup < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :item_id, ID, required: false
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :selection_required_max, Integer, required: false
      argument :selection_required_min, Integer, required: false

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(id:, item_id: nil, **attributes)
        modifier_group = ::ModifierGroup.find(id)
        modifier_group.update!(attributes)

        if modifier_group.item_modifier_group
          modifier_group.item_modifier_group.update!(item_id: item_id)
        else
          ::ItemModifierGroup.create!(item_id: item_id, modifier_group_id: modifier_group.id)
        end

        { modifier_group: modifier_group }
      end
    end
  end
end
