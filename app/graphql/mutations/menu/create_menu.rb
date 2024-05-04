module Mutations
  module Menu
    class CreateMenu < Mutations::BaseMutation
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :state, String, required: true
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: true

      field :menu, Types::MenuType, null: false

      def resolve(**attributes)
        menu = ::Menu.create!(attributes)
        { menu: menu }
      end
    end
  end
end
