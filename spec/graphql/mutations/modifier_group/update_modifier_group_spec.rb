require 'rails_helper'

RSpec.describe Mutations::ModifierGroup::UpdateModifierGroup, type: :request do
  let(:modifier_group) { create(:modifier_group) }
  let(:new_item) { create(:item) }

  describe '.resolve' do
    it 'updates a modifier group and associates it with a new item' do
      post '/graphql', params: { query: query(modifier_group.id, new_item.id) }

      modifier_group.reload
      expect(modifier_group.item).to eq(new_item)
      expect(modifier_group.identifier).to eq('updated_modifier_group')
      expect(modifier_group.label).to eq('Updated Modifier Group')
      expect(modifier_group.selection_required_max).to eq(5)
      expect(modifier_group.selection_required_min).to eq(2)
    end
  end

  def query(modifier_group_id, item_id)
    <<~GQL
      mutation {
        updateModifierGroup(input: {
          id: "#{modifier_group_id}",
          itemId: "#{item_id}",
          identifier: "updated_modifier_group",
          label: "Updated Modifier Group",
          selectionRequiredMax: 5,
          selectionRequiredMin: 2
        }) {
          modifierGroup {
            id
            identifier
            label
            selectionRequiredMax
            selectionRequiredMin
          }
        }
      }
    GQL
  end
end
