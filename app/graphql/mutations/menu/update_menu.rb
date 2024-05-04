module Mutations
  module Menu
    class UpdateMenu < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :state, String, required: false
      argument :start_date, GraphQL::Types::ISO8601Date, required: false
      argument :end_date, GraphQL::Types::ISO8601Date, required: false

      field :menu, Types::MenuType, null: false

      def resolve(id:, **attributes)
        menu = ::Menu.find(id)
        menu.update!(attributes)
        { menu: menu }
      end
    end
  end
end
