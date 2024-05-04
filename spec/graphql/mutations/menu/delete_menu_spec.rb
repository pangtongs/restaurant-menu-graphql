require "rails_helper"

RSpec.describe Mutations::Menu::DeleteMenu, type: :request do
  let!(:menu) { create(:menu) }

  describe '.resolve' do
    it 'deletes a menu' do
      expect do
        post '/graphql', params: { query: query(menu.id) }
      end.to change { ::Menu.count }.by(-1)
    end
  end

  def query(menu_id)
    <<~GQL
      mutation {
        deleteMenu(input: {
          id: "#{menu_id}"
        }) {
          menu {
            id
          }
        }
      }
    GQL
  end
end
