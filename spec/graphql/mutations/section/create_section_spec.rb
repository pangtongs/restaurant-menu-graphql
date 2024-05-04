require 'rails_helper'

RSpec.describe Mutations::Section::CreateSection, type: :request do
  let(:menu) { create(:menu) }

  describe '.resolve' do
    it 'creates a section and associates it with the menu' do
      expect do
        post '/graphql', params: { query: query(menu.id) }
      end.to change { ::Section.count }.by(1)

      section = ::Section.last
      expect(section.identifier).to eq('section1')
      expect(section.label).to eq('Section 1')
      expect(section.description).to eq('Description of Section 1')
      expect(section.menu).to eq(menu)
    end
  end

  def query(menu_id)
    <<~GQL
      mutation {
        createSection(input: {
          menuId: "#{menu_id}",
          identifier: "section1",
          label: "Section 1",
          description: "Description of Section 1"
        }) {
          section {
            id
            identifier
            label
            description
          }
        }
      }
    GQL
  end
end
