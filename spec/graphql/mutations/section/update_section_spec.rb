require 'rails_helper'

RSpec.describe Mutations::Section::UpdateSection, type: :request do
  let(:section) { create(:section) }
  let(:menu) { create(:menu) }

  describe '.resolve' do
    it 'updates a section and associates it with the menu' do
      post '/graphql', params: { query: query(section.id, menu.id) }

      section.reload
      expect(section.label).to eq('Updated Section Label')
      expect(section.description).to eq('Updated Section Description')
      expect(section.menu).to eq(menu)
    end
  end

  def query(section_id, menu_id)
    <<~GQL
      mutation {
        updateSection(input: {
          id: "#{section_id}",
          menuId: "#{menu_id}",
          label: "Updated Section Label",
          description: "Updated Section Description"
        }) {
          section {
            id
            label
            description
          }
        }
      }
    GQL
  end
end
