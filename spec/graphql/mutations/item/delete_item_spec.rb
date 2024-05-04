require 'rails_helper'

RSpec.describe Mutations::Item::DeleteItem, type: :request do
  let!(:item) { create(:item) }

  describe '.resolve' do
    it 'deletes an item' do
      expect do
        post '/graphql', params: { query: query(item.id) }
      end.to change { ::Item.count }.by(-1)
    end
  end

  def query(item_id)
    <<~GQL
      mutation {
        deleteItem(input: {
          id: "#{item_id}"
        }) {
          item {
            id
          }
        }
      }
    GQL
  end
end
