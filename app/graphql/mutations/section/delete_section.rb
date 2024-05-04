module Mutations
  module Section
    class DeleteSection < Mutations::BaseMutation
      argument :id, ID, required: true

      field :section, Types::SectionType, null: false

      def resolve(id:)
        section = ::Section.find(id)
        section.destroy!
        { section: section }
      end
    end
  end
end
