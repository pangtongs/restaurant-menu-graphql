# db/seeds.rb
# Create menus
menu1 = Menu.create(identifier: 'MENU1', label: 'Lunch Menu', state: 'active', start_date: Date.today, end_date: Date.today + 30)
menu2 = Menu.create(identifier: 'MENU2', label: 'Dinner Menu', state: 'active', start_date: Date.today, end_date: Date.today + 30)

# Create sections
section1 = Section.create(identifier: 'SECTION1', label: 'Appetizers', description: 'Delicious starters')
section2 = Section.create(identifier: 'SECTION2', label: 'Main Course', description: 'Mouth-watering entrees')
section3 = Section.create(identifier: 'SECTION3', label: 'Desserts', description: 'Sweet treats')

# Associate sections with menus
MenuSection.create(menu: menu1, section: section1, display_order: 1)
MenuSection.create(menu: menu1, section: section2, display_order: 2)
MenuSection.create(menu: menu2, section: section2, display_order: 1)
MenuSection.create(menu: menu2, section: section3, display_order: 2)

# Create items
item1 = Item.create(item_type: 'Product', identifier: 'ITEM1', label: 'Caesar Salad', description: 'Fresh romaine lettuce with caesar dressing', price: 9.99)
item2 = Item.create(item_type: 'Product', identifier: 'ITEM2', label: 'Grilled Chicken', description: 'Juicy grilled chicken breast', price: 14.99)
item3 = Item.create(item_type: 'Product', identifier: 'ITEM3', label: 'Margherita Pizza', description: 'Classic pizza with tomato sauce and mozzarella', price: 12.99)
item4 = Item.create(item_type: 'Component', identifier: 'ITEM4', label: '10" Pizza', description: '10-inch pizza size', price: 0.0)
item5 = Item.create(item_type: 'Component', identifier: 'ITEM5', label: '12" Pizza', description: '12-inch pizza size', price: 2.0)
item6 = Item.create(item_type: 'Product', identifier: 'ITEM6', label: 'Tiramisu', description: 'Classic Italian dessert', price: 6.99)

# Associate items with sections
SectionItem.create(section: section1, item: item1, display_order: 1)
SectionItem.create(section: section2, item: item2, display_order: 1)
SectionItem.create(section: section2, item: item3, display_order: 2)
SectionItem.create(section: section3, item: item6, display_order: 1)

# Create modifier groups
modifier_group1 = ModifierGroup.create(identifier: 'MG1', label: 'Pizza Size', selection_required_min: 1, selection_required_max: 1)

# Create modifiers
Modifier.create(item: item4, modifier_group: modifier_group1, display_order: 1, default_quantity: 1)
Modifier.create(item: item5, modifier_group: modifier_group1, display_order: 2)

# Associate modifier groups with items
ItemModifierGroup.create(item: item3, modifier_group: modifier_group1)
