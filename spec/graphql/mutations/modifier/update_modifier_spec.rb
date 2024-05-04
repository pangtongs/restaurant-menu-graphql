require 'rails_helper'

RSpec.describe Mutations::Modifier::UpdateModifier, type: :request do
  let(:modifier) { create(:modifier) }

  describe '.resolve' do
    it 'updates a modifier' do
      post '/graphql', params: { query: query(modifier.id) }

      modifier.reload
      expect(modifier.display_order).to eq(3)
      expect(modifier.default_quantity).to eq(4)
      expect(modifier.price_override).to eq(2.5)
    end
  end

  def query(modifier_id)
    <<~GQL
      mutation {
        updateModifier(input: {
          id: "#{modifier_id}",
          displayOrder: 3,
          defaultQuantity: 4,
          priceOverride: 2.5
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
