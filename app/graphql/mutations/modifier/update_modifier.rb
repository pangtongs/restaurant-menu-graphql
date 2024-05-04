module Mutations
  module Modifier
    class UpdateModifier < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :display_order, Integer, required: false
      argument :default_quantity, Integer, required: false
      argument :price_override, Float, required: false

      field :modifier, Types::ModifierType, null: false

      def resolve(id:, **attributes)
        modifier = ::Modifier.find(id)
        modifier.update!(attributes)
        { modifier: modifier }
      end
    end
  end
end
