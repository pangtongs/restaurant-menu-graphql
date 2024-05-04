# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_menu, mutation: Mutations::Menu::CreateMenu
    field :update_menu, mutation: Mutations::Menu::UpdateMenu
    field :delete_menu, mutation: Mutations::Menu::DeleteMenu

    field :create_item, mutation: Mutations::Item::CreateItem
    field :update_item, mutation: Mutations::Item::UpdateItem
    field :delete_item, mutation: Mutations::Item::DeleteItem

    field :create_section, mutation: Mutations::Section::CreateSection
    field :update_section, mutation: Mutations::Section::UpdateSection
    field :delete_section, mutation: Mutations::Section::DeleteSection

    field :create_modifier_group, mutation: Mutations::ModifierGroup::CreateModifierGroup
    field :update_modifier_group, mutation: Mutations::ModifierGroup::UpdateModifierGroup
    field :delete_modifier_group, mutation: Mutations::ModifierGroup::DeleteModifierGroup

    field :create_modifier, mutation: Mutations::Modifier::CreateModifier
    field :update_modifier, mutation: Mutations::Modifier::UpdateModifier
    field :delete_modifier, mutation: Mutations::Modifier::DeleteModifier

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
