module Types
  class QueryType < Types::BaseObject
    field :menus, [Types::MenuType], null: false do
      description "Returns a list of menus"
    end

    def menus
      Menu.all
    end

    field :menu, Types::MenuType, null: true do
      description "Returns a specific menu by ID"
      argument :id, ID, required: true
    end

    def menu(id:)
      Menu.find_by(id: id)
    end

    field :sections, [Types::SectionType], null: false do
      description "Returns a list of sections"
    end

    def sections
      Section.all
    end

    field :section, Types::SectionType, null: true do
      description "Returns a specific section by ID"
      argument :id, ID, required: true
    end

    def section(id:)
      Section.find_by(id: id)
    end

    field :items, [Types::ItemType], null: false do
      description "Returns a list of items"
    end

    def items
      Item.all
    end

    field :item, Types::ItemType, null: true do
      description "Returns a specific item by ID"
      argument :id, ID, required: true
    end

    def item(id:)
      Item.find_by(id: id)
    end

    field :modifier_groups, [Types::ModifierGroupType], null: false do
      description "Returns a list of modifier groups"
    end

    def modifier_groups
      ModifierGroup.all
    end

    field :modifier_group, Types::ModifierGroupType, null: true do
      description "Returns a specific modifier group by ID"
      argument :id, ID, required: true
    end

    def modifier_group(id:)
      ModifierGroup.find_by(id: id)
    end

    field :modifiers, [Types::ModifierType], null: false do
      description "Returns a list of modifiers"
    end

    def modifiers
      Modifier.all
    end

    field :modifier, Types::ModifierType, null: true do
      description "Returns a specific modifier by ID"
      argument :id, ID, required: true
    end

    def modifier(id:)
      Modifier.find_by(id: id)
    end
  end
end
