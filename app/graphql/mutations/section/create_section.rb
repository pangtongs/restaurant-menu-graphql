module Mutations
  module Section
    class CreateSection < Mutations::BaseMutation
      argument :menu_id, ID, required: true
      argument :identifier, String, required: true
      argument :label, String, required: true
      argument :description, String, required: false

      field :section, Types::SectionType, null: false

      def resolve(menu_id:, **attributes)
        menu = ::Menu.find(menu_id)
        section = ::Section.create!(attributes)
        menu.sections << section
        { section: section }
      end
    end
  end
end
