require 'rails_helper'

RSpec.describe Mutations::ModifierGroup::CreateModifierGroup, type: :request do
  let(:item) { create(:item) }

  describe '.resolve' do
    it 'creates a modifier group associated with the item' do
      expect {
        post '/graphql', params: { query: query(item.id) }
        puts response.body
      }.to change { ::ModifierGroup.count }.by(1)

      modifier_group = ::ModifierGroup.last
      expect(modifier_group.item).to eq(item)
      expect(modifier_group.identifier).to eq('modifier_group_1')
      expect(modifier_group.label).to eq('Modifier Group 1')
      expect(modifier_group.selection_required_max).to eq(3)
      expect(modifier_group.selection_required_min).to eq(1)
    end
  end

  def query(item_id)
    <<~GQL
      mutation {
        createModifierGroup(input: {
          itemId: "#{item_id}",
          identifier: "modifier_group_1",
          label: "Modifier Group 1",
          selectionRequiredMax: 3,
          selectionRequiredMin: 1
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
