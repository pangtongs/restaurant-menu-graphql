module Mutations
  module Menu
    class DeleteMenu < Mutations::BaseMutation
      argument :id, ID, required: true

      field :menu, Types::MenuType, null: false

      def resolve(id:)
        menu = ::Menu.find(id)
        menu.destroy!
        { menu: menu }
      end
    end
  end
end
