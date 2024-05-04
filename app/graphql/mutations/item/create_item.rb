module Mutations
  module Item
    class CreateItem < Mutations::BaseMutation
      argument :section_id, ID, required: true
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :description, String, required: false
      argument :price, Float, required: true
      argument :item_type, String, required: true

      field :item, Types::ItemType, null: false

      def resolve(section_id:, **attributes)
        section = ::Section.find(section_id)
        item = section.items.create!(attributes)
        { item: item }
      end
    end
  end
end
