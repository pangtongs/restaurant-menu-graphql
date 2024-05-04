module Mutations
  module Section
    class UpdateSection < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :menu_id, ID, required: false
      argument :identifier, String, required: false
      argument :label, String, required: false
      argument :description, String, required: false

      field :section, Types::SectionType, null: false

      def resolve(id:, menu_id: nil, **attributes)
        section = ::Section.find(id)
        section.update!(attributes)

        if section.menu_section
          section.menu_section.update!(menu_id: menu_id)
        else
          ::MenuSection.create!(section: section, menu_id: menu_id)
        end

        { section: section }
      end
    end
  end
end
