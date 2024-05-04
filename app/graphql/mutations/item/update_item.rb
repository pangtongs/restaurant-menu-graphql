module Mutations
  module Item
    class UpdateItem < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :description, String, required: false
      argument :price, Float, required: false

      field :item, Types::ItemType, null: false

      def resolve(id:, **attributes)
        item = ::Item.find(id)
        item.update!(attributes)
        { item: item }
      end
    end
  end
end
