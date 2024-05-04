module Mutations
  module Modifier
    class DeleteModifier < Mutations::BaseMutation
      argument :id, ID, required: true

      field :modifier, Types::ModifierType, null: false

      def resolve(id:)
        modifier = ::Modifier.find(id)
        modifier.destroy!
        { modifier: modifier }
      end
    end
  end
end
