module Mutations
  module Modifier
    class CreateModifier < Mutations::BaseMutation
      argument :item_id, ID, required: true
      argument :modifier_group_id, ID, required: true
      argument :display_order, Integer, required: false
      argument :default_quantity, Integer, required: false
      argument :price_override, Float, required: false

      field :modifier, Types::ModifierType, null: false

      def resolve(item_id:, modifier_group_id:, **attributes)
        item = ::Item.find(item_id)
        modifier_group = ::ModifierGroup.find(modifier_group_id)
        modifier = ::Modifier.create!(item: item, modifier_group: modifier_group, **attributes)
        { modifier: modifier }
      end
    end
  end
end
