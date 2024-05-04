require "rails_helper"

RSpec.describe Types::QueryType do
  describe "menus" do
    let!(:menus) { create_list(:menu, 3) }

    let(:query) do
      %(query {
        menus {
          id
          identifier
          label
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns all menus" do
      expect(result.dig("data", "menus")).to match_array(
        menus.map { |menu| { "id" => menu.id.to_s, "identifier" => menu.identifier, "label" => menu.label } }
      )
    end
  end

  describe "menu" do
    let!(:menu) { create(:menu) }

    let(:query) do
      %(query {
        menu(id: "#{menu.id}") {
          id
          identifier
          label
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns a specific menu" do
      expect(result.dig("data", "menu")).to include(
        "id" => menu.id.to_s,
        "identifier" => menu.identifier,
        "label" => menu.label
      )
    end
  end

  describe "sections" do
    let!(:sections) { create_list(:section, 3) }

    let(:query) do
      %(query {
        sections {
          id
          identifier
          label
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns all sections" do
      expect(result.dig("data", "sections")).to match_array(
        sections.map { |section| { "id" => section.id.to_s, "identifier" => section.identifier, "label" => section.label } }
      )
    end
  end

  describe "items" do
    let!(:items) { create_list(:item, 3) }

    let(:query) do
      %(query {
        items {
          id
          identifier
          label
          price
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns all items" do
      expect(result.dig("data", "items")).to match_array(
        items.map { |item| { "id" => item.id.to_s, "identifier" => item.identifier, "label" => item.label, "price" => item.price.to_f } }
      )
    end
  end

  describe "modifier_groups" do
    let!(:modifier_groups) { create_list(:modifier_group, 3) }

    let(:query) do
      %(query {
        modifierGroups {
          id
          identifier
          label
          selectionRequiredMin
          selectionRequiredMax
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns all modifier groups" do
      expect(result.dig("data", "modifierGroups")).to match_array(
        modifier_groups.map do |modifier_group|
          {
            "id" => modifier_group.id.to_s,
            "identifier" => modifier_group.identifier,
            "label" => modifier_group.label,
            "selectionRequiredMin" => modifier_group.selection_required_min,
            "selectionRequiredMax" => modifier_group.selection_required_max
          }
        end
      )
    end
  end

  describe "modifier_group" do
    let!(:modifier_group) { create(:modifier_group) }

    let(:query) do
      %(query {
        modifierGroup(id: "#{modifier_group.id}") {
          id
          identifier
          label
          selectionRequiredMin
          selectionRequiredMax
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns a specific modifier group" do
      expect(result.dig("data", "modifierGroup")).to include(
        "id" => modifier_group.id.to_s,
        "identifier" => modifier_group.identifier,
        "label" => modifier_group.label,
        "selectionRequiredMin" => modifier_group.selection_required_min,
        "selectionRequiredMax" => modifier_group.selection_required_max
      )
    end
  end

  describe "modifiers" do
    let!(:modifiers) { create_list(:modifier, 3) }

    let(:query) do
      %(query {
        modifiers {
          id
          displayOrder
          defaultQuantity
          priceOverride
          item {
            id
          }
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns all modifiers" do
      expect(result.dig("data", "modifiers")).to match_array(
        modifiers.map do |modifier|
          {
            "id" => modifier.id.to_s,
            "displayOrder" => modifier.display_order,
            "defaultQuantity" => modifier.default_quantity,
            "priceOverride" => modifier.price_override.to_f,
            "item" => {
              "id" => modifier.item.id.to_s
            }
          }
        end
      )
    end
  end

  describe "modifier" do
    let!(:modifier) { create(:modifier) }

    let(:query) do
      %(query {
        modifier(id: "#{modifier.id}") {
          id
          displayOrder
          defaultQuantity
          priceOverride
          item {
            id
          }
        }
      })
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it "returns a specific modifier" do
      expect(result.dig("data", "modifier")).to include(
        "id" => modifier.id.to_s,
        "displayOrder" => modifier.display_order,
        "defaultQuantity" => modifier.default_quantity,
        "priceOverride" => modifier.price_override.to_f,
        "item" => {
          "id" => modifier.item.id.to_s
        }
      )
    end
  end
end
