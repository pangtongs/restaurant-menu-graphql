require 'rails_helper'

RSpec.describe Mutations::ModifierGroup::DeleteModifierGroup, type: :request do
  let!(:modifier_group) { create(:modifier_group) }

  describe '.resolve' do
    it 'deletes a modifier group' do
      expect do
        post '/graphql', params: { query: query(modifier_group.id) }
      end.to change { ::ModifierGroup.count }.by(-1)
    end
  end

  def query(modifier_group_id)
    <<~GQL
      mutation {
        deleteModifierGroup(input: {
          id: "#{modifier_group_id}"
        }) {
          modifierGroup {
            id
          }
        }
      }
    GQL
  end
end
