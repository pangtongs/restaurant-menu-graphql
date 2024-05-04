require 'rails_helper'

RSpec.describe Mutations::Item::CreateItem, type: :request do
  let(:section) { create(:section) }

  describe '.resolve' do
    it 'creates an item' do
      expect do
        post '/graphql', params: { query: query(section.id) }
      end.to change { ::Item.count }.by(1)

      item = ::Item.last
      expect(item.label).to eq('Item 1')
      expect(item.description).to eq('Description of Item 1')
      expect(item.price).to eq(9.99)
      expect(item.section).to eq(section)
      expect(item.identifier).to eq("sample identifier")
      expect(item.item_type).to eq("Product")
    end
  end

  def query(section_id)
    <<~GQL
      mutation {
        createItem(input: {
          itemType: "Product",
          sectionId: "#{section_id}",
          label: "Item 1",
          description: "Description of Item 1",
          identifier: "sample identifier",
          price: 9.99
        }) {
          item {
            id
            label
            description
            price
          }
        }
      }
    GQL
  end
end
