module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :item_type, String, null: false
    field :identifier, String, null: false
    field :label, String, null: false
    field :description, String
    field :price, Float, null: false
    field :modifier_groups, [Types::ModifierGroupType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
