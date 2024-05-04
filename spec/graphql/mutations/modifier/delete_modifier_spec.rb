require 'rails_helper'

RSpec.describe Mutations::Modifier::DeleteModifier, type: :request do
  let!(:modifier) { create(:modifier) }

  describe '.resolve' do
    it 'deletes a modifier' do
      expect do
        post '/graphql', params: { query: query(modifier.id) }
      end.to change { ::Modifier.count }.by(-1)
    end
  end

  def query(modifier_id)
    <<~GQL
      mutation {
        deleteModifier(input: {
          id: "#{modifier_id}"
        }) {
          modifier {
            id
          }
        }
      }
    GQL
  end
end
