require "rails_helper"

RSpec.describe Mutations::Menu::CreateMenu, type: :request do
  describe '.resolve' do
    it 'creates a menu' do
      expect do
        post '/graphql', params: { query: query }
      end.to change { ::Menu.count }.by(1)

      menu = ::Menu.last
      expect(menu.identifier).to eq('menu1')
      expect(menu.label).to eq('Menu 1')
      expect(menu.state).to eq('active')
      expect(menu.start_date).to eq(Date.parse('2023-05-01'))
      expect(menu.end_date).to eq(Date.parse('2023-05-31'))
    end
  end

  def query
    <<~GQL
      mutation {
        createMenu(input: {
          identifier: "menu1",
          label: "Menu 1",
          state: "active",
          startDate: "2023-05-01",
          endDate: "2023-05-31"
        }) {
          menu {
            id
            identifier
            label
            state
            startDate
            endDate
          }
        }
      }
    GQL
  end
end
