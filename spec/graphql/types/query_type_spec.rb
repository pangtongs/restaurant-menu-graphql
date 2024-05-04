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

  describe 'menu with sections, items, modifier groups, and modifiers' do
    let!(:menu) { create(:menu) }
    let!(:section) { create(:section, menu: menu) }
    let!(:item) { create(:item, section: section) }
    let!(:modifier_group) { create(:modifier_group, item: item) }
    let!(:modifier1) { create(:modifier, modifier_group: modifier_group, item: item) }
    let!(:modifier2) { create(:modifier, modifier_group: modifier_group, item: item) }

    let(:query) do
      <<~GQL
        query {
          menus {
            id
            identifier
            label
            state
            startDate
            endDate
            sections {
              id
              identifier
              label
              description
              items {
                id
                itemType
                identifier
                label
                description
                price
                modifierGroups {
                  id
                  identifier
                  label
                  selectionRequiredMin
                  selectionRequiredMax
                  modifiers {
                    id
                    displayOrder
                    defaultQuantity
                    priceOverride
                  }
                }
              }
            }
          }
        }
      GQL
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it 'returns the menu with associated sections, items, modifier groups, and modifiers' do

      expect(result.dig('data', 'menus')).to match_array(
        [
          {
            'id' => menu.id.to_s,
            'identifier' => menu.identifier,
            'label' => menu.label,
            'state' => menu.state,
            'startDate' => menu.start_date.iso8601,
            'endDate' => menu.end_date.iso8601,
            'sections' => [
              {
                'id' => section.id.to_s,
                'identifier' => section.identifier,
                'label' => section.label,
                'description' => section.description,
                'items' => [
                  {
                    'id' => item.id.to_s,
                    'itemType' => item.item_type,
                    'identifier' => item.identifier,
                    'label' => item.label,
                    'description' => item.description,
                    'price' => item.price.to_f,
                    'modifierGroups' => [
                      {
                        'id' => modifier_group.id.to_s,
                        'identifier' => modifier_group.identifier,
                        'label' => modifier_group.label,
                        'selectionRequiredMin' => modifier_group.selection_required_min,
                        'selectionRequiredMax' => modifier_group.selection_required_max,
                        'modifiers' => [
                          {
                            'id' => modifier1.id.to_s,
                            'displayOrder' => modifier1.display_order,
                            'defaultQuantity' => modifier1.default_quantity,
                            'priceOverride' => modifier1.price_override.to_f
                          },
                          {
                            'id' => modifier2.id.to_s,
                            'displayOrder' => modifier2.display_order,
                            'defaultQuantity' => modifier2.default_quantity,
                            'priceOverride' => modifier2.price_override.to_f
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      )
    end
  end

  describe 'menus, sections, items, modifier groups, and modifiers query' do
    let!(:menus) { create_list(:menu, 3) }
    let!(:sections) { create_list(:section, 3) }
    let!(:items) { create_list(:item, 3) }
    let!(:modifier_groups) do
      items.map.with_index do |item, index|
        create(:modifier_group, item: item)
      end
    end
    let!(:modifiers) { create_list(:modifier, 3, item: items.first) }

    let(:query) do
      <<~GQL
        query {
          menus {
            id
            identifier
            label
            state
            startDate
            endDate
          }
          sections {
            id
            identifier
            label
            description
          }
          items {
            id
            itemType
            identifier
            label
            description
            price
          }
          modifierGroups {
            id
            identifier
            label
            selectionRequiredMin
            selectionRequiredMax
          }
          modifiers {
            id
            displayOrder
            defaultQuantity
            priceOverride
            item {
              id
            }
          }
        }
      GQL
    end

    subject(:result) do
      RestaurantMenuSchema.execute(query).as_json
    end

    it 'returns all menus, sections, items, modifier groups, and modifiers' do
      expect(result.dig('data', 'menus')).to match_array(
        menus.map do |menu|
          {
            'id' => menu.id.to_s,
            'identifier' => menu.identifier,
            'label' => menu.label,
            'state' => menu.state,
            'startDate' => menu.start_date.iso8601,
            'endDate' => menu.end_date.iso8601
          }
        end
      )

      expect(result.dig('data', 'sections')).to match_array(
        sections.map do |section|
          {
            'id' => section.id.to_s,
            'identifier' => section.identifier,
            'label' => section.label,
            'description' => section.description
          }
        end
      )

      expect(result.dig('data', 'items')).to match_array(
        items.map do |item|
          {
            'id' => item.id.to_s,
            'itemType' => item.item_type,
            'identifier' => item.identifier,
            'label' => item.label,
            'description' => item.description,
            'price' => item.price.to_f
          }
        end
      )

      expect(result.dig('data', 'modifierGroups').first(3)).to match_array(
        modifier_groups.map do |modifier_group|
          {
            'id' => modifier_group.id.to_s,
            'identifier' => modifier_group.identifier,
            'label' => modifier_group.label,
            'selectionRequiredMin' => modifier_group.selection_required_min,
            'selectionRequiredMax' => modifier_group.selection_required_max
          }
        end
      )

      expect(result.dig('data', 'modifiers')).to match_array(
        modifiers.map do |modifier|
          {
            'id' => modifier.id.to_s,
            'displayOrder' => modifier.display_order,
            'defaultQuantity' => modifier.default_quantity,
            'priceOverride' => modifier.price_override.to_f,
            'item' => {
              'id' => modifier.item.id.to_s
            }
          }
        end
      )
    end
  end
end
