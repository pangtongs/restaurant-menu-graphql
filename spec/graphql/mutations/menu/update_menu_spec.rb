require "rails_helper"

RSpec.describe Mutations::Menu::UpdateMenu, type: :request do
  let!(:menu) { create(:menu) }

  describe '.resolve' do
    it 'updates a menu' do
      post '/graphql', params: { query: query(menu.id) }

      menu.reload
      expect(menu.label).to eq('Updated Menu Label')
    end
  end

  def query(menu_id)
    <<~GQL
      mutation {
        updateMenu(input: {
          id: "#{menu_id}",
          label: "Updated Menu Label"
        }) {
          menu {
            id
            label
          }
        }
      }
    GQL
  end
end
