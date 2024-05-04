require 'rails_helper'

RSpec.describe Mutations::Section::DeleteSection, type: :request do
  let!(:section) { create(:section) }

  describe '.resolve' do
    it 'deletes a section' do
      expect do
        post '/graphql', params: { query: query(section.id) }
      end.to change { ::Section.count }.by(-1)
    end
  end

  def query(section_id)
    <<~GQL
      mutation {
        deleteSection(input: {
          id: "#{section_id}"
        }) {
          section {
            id
          }
        }
      }
    GQL
  end
end
