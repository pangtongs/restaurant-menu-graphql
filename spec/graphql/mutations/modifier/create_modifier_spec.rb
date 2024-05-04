require 'rails_helper'

RSpec.describe Mutations::Modifier::CreateModifier, type: :request do
  let(:item) { create(:item) }
  let(:modifier_group) { create(:modifier_group) }

  describe '.resolve' do
    it 'creates a modifier' do
      expect do
        post '/graphql', params: { query: query(item.id, modifier_group.id) }
      end.to change { ::Modifier.count }.by(1)

      modifier = ::Modifier.last
      expect(modifier.item).to eq(item)
      expect(modifier.modifier_group).to eq(modifier_group)
      expect(modifier.display_order).to eq(1)
      expect(modifier.default_quantity).to eq(2)
      expect(modifier.price_override).to eq(1.5)
    end
  end

  def query(item_id, modifier_group_id)
    <<~GQL
      mutation {
        createModifier(input: {
          itemId: "#{item_id}",
          modifierGroupId: "#{modifier_group_id}",
          displayOrder: 1,
          defaultQuantity: 2,
          priceOverride: 1.5
        }) {
          modifier {
            id
            displayOrder
            defaultQuantity
            priceOverride
          }
        }
      }
    GQL
  end
end
