// lib/features/business/types/restaurant/screens/menu_management_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class MenuManagementScreen extends StatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  State<MenuManagementScreen> createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  final Map<String, List<Map<String, dynamic>>> _menuByCategory = {
    'Appetizers': [
      {
        'id': 1,
        'name': 'Siwa Date Salad',
        'price': 12.0,
        'description': 'Fresh dates with local greens',
        'ingredients': ['Dates', 'Lettuce', 'Olive Oil'],
        'isSpecial': false,
      },
      {
        'id': 2,
        'name': 'Grilled Halloumi',
        'price': 15.0,
        'description': 'Traditional cheese with herbs',
        'ingredients': ['Halloumi', 'Herbs', 'Lemon'],
        'isSpecial': true,
      },
    ],
    'Main Course': [
      {
        'id': 3,
        'name': 'Oasis Lamb Tagine',
        'price': 35.0,
        'description': 'Slow-cooked lamb with vegetables',
        'ingredients': ['Lamb', 'Vegetables', 'Spices'],
        'isSpecial': false,
      },
      {
        'id': 4,
        'name': 'Desert Grilled Fish',
        'price': 30.0,
        'description': 'Fresh fish from Siwa springs',
        'ingredients': ['Fish', 'Herbs', 'Garlic'],
        'isSpecial': true,
      },
    ],
    'Desserts': [
      {
        'id': 5,
        'name': 'Date & Honey Cake',
        'price': 10.0,
        'description': 'Traditional Siwan dessert',
        'ingredients': ['Dates', 'Honey', 'Flour'],
        'isSpecial': false,
      },
    ],
  };

  final Map<String, dynamic> _seatingInfo = {
    'totalTables': 15,
    'availableTables': 8,
    'reservationsToday': 12,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Menu Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddMenuItem,
            tooltip: 'Add Menu Item',
          ),
          IconButton(
            icon: const Icon(Icons.table_restaurant),
            onPressed: _showSeatingOverview,
            tooltip: 'Seating',
          ),
        ],
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(16),
        onReorder: (oldIndex, newIndex) {
          // Handle reordering logic
        },
        children: _menuByCategory.entries.map((entry) {
          return ExpansionTile(
            key: ValueKey(entry.key),
            title: Text(
              entry.key,
              style: AppTheme.titleLarge,
            ),
            subtitle: Text('${entry.value.length} items'),
            initiallyExpanded: true,
            children: entry.value.map((item) => _buildMenuItem(item, entry.key)).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, String category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image Placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.lightBlueGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                size: 40,
                color: AppTheme.primaryOrange,
              ),
            ),
            const SizedBox(width: 16),
            
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item['name'],
                          style: AppTheme.titleMedium,
                        ),
                      ),
                      if (item['isSpecial'])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.warningYellow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Special',
                            style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['description'],
                    style: AppTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ingredients: ${item['ingredients'].join(', ')}',
                    style: AppTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item['price'].toStringAsFixed(0)}',
                        style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            color: AppTheme.primaryOrange,
                            onPressed: () => _showEditMenuItem(item, category),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: Icon(
                              item['isSpecial'] ? Icons.star : Icons.star_border,
                              size: 20,
                            ),
                            color: AppTheme.warningYellow,
                            onPressed: () {
                              setState(() {
                                item['isSpecial'] = !item['isSpecial'];
                              });
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 20),
                            color: AppTheme.errorRed,
                            onPressed: () => _confirmDelete(item, category),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMenuItem() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descController = TextEditingController();
    String selectedCategory = 'Appetizers';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Menu Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: _menuByCategory.keys.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                onChanged: (value) => selectedCategory = value!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  _menuByCategory[selectedCategory]?.add({
                    'id': DateTime.now().millisecondsSinceEpoch,
                    'name': nameController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'description': descController.text,
                    'ingredients': ['Add ingredients'],
                    'isSpecial': false,
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menu item added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditMenuItem(Map<String, dynamic> item, String category) {
    final nameController = TextEditingController(text: item['name']);
    final priceController = TextEditingController(text: item['price'].toString());
    final descController = TextEditingController(text: item['description']);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Menu Item'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                item['name'] = nameController.text;
                item['price'] = double.tryParse(priceController.text) ?? item['price'];
                item['description'] = descController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu item updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Map<String, dynamic> item, String category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Remove "${item['name']}" from menu?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _menuByCategory[category]?.remove(item);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showSeatingOverview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seating Overview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSeatingInfo('Total Tables', _seatingInfo['totalTables'].toString(), AppTheme.primaryOrange),
            const SizedBox(height: 12),
            _buildSeatingInfo('Available', _seatingInfo['availableTables'].toString(), AppTheme.successGreen),
            const SizedBox(height: 12),
            _buildSeatingInfo('Reservations Today', _seatingInfo['reservationsToday'].toString(), AppTheme.oasisTeal),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatingInfo(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTheme.bodyLarge),
        Text(
          value,
          style: AppTheme.titleLarge.copyWith(color: color),
        ),
      ],
    );
  }
}