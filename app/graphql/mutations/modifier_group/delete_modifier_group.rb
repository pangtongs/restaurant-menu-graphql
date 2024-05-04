module Mutations
  module ModifierGroup
    class DeleteModifierGroup < Mutations::BaseMutation
      argument :id, ID, required: true

      field :modifier_group, Types::ModifierGroupType, null: false

      def resolve(id:)
        modifier_group = ::ModifierGroup.find(id)
        modifier_group.destroy!
        { modifier_group: modifier_group }
      end
    end
  end
end
