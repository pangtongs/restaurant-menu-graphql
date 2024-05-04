require 'rails_helper'

RSpec.describe Mutations::Item::UpdateItem, type: :request do
  let(:item) { create(:item) }

  describe '.resolve' do
    it 'updates an item' do
      post '/graphql', params: { query: query(item.id) }

      item.reload
      expect(item.label).to eq('Updated Item Name')
    end
  end

  def query(item_id)
    <<~GQL
      mutation {
        updateItem(input: {
          id: "#{item_id}",
          label: "Updated Item Name"
        }) {
          item {
            id
            label
          }
        }
      }
    GQL
  end
end
