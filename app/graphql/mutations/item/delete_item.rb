module Mutations
  module Item
    class DeleteItem < Mutations::BaseMutation
      argument :id, ID, required: true

      field :item, Types::ItemType, null: false

      def resolve(id:)
        item = ::Item.find(id)
        item.destroy!
        { item: item }
      end
    end
  end
end
