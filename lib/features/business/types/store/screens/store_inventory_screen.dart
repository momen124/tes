// lib/features/business/types/store/screens/store_inventory_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image_picker/image_picker.dart';

class StoreInventoryScreen extends StatefulWidget {
  const StoreInventoryScreen({super.key});

  @override
  State<StoreInventoryScreen> createState() => _StoreInventoryScreenState();
}

class _StoreInventoryScreenState extends State<StoreInventoryScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  
  final List<Map<String, dynamic>> _products = [
    {
      'id': 1,
      'name': 'Siwa Olive Oil',
      'price': 25.0,
      'stock': 45,
      'category': 'Food',
      'lowStockThreshold': 20,
      'image': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg',
    },
    {
      'id': 2,
      'name': 'Handwoven Basket',
      'price': 35.0,
      'stock': 12,
      'category': 'Crafts',
      'lowStockThreshold': 15,
      'image': 'https://media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/10/70/9f/ba.jpg',
    },
    {
      'id': 3,
      'name': 'Date Palm Honey',
      'price': 30.0,
      'stock': 8,
      'category': 'Food',
      'lowStockThreshold': 10,
      'image': 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/36375216.jpg',
    },
    {
      'id': 4,
      'name': 'Siwa Salt Lamp',
      'price': 50.0,
      'stock': 25,
      'category': 'Crafts',
      'lowStockThreshold': 15,
      'image': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg',
    },
  ];

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 1,
      'customer': 'Emily Johnson',
      'items': ['Olive Oil x2', 'Basket x1'],
      'total': 85.0,
      'status': 'pending',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': 2,
      'customer': 'Ahmed Khalil',
      'items': ['Date Honey x3'],
      'total': 90.0,
      'status': 'processing',
      'date': DateTime.now().subtract(const Duration(hours: 5)),
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    return _products.where((product) {
      final matchesSearch = product['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || product['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/business_dashboard'),
        ),
        title: const Text('Store Inventory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddProductDialog,
            tooltip: 'Add Product',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          _buildLowStockAlert(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showOrdersBottomSheet,
        icon: const Icon(Icons.receipt_long),
        label: Text('Orders (${_orders.length})'),
        backgroundColor: AppTheme.primaryOrange,
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search, color: AppTheme.primaryOrange),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppTheme.secondaryGray.withOpacity(0.3)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['All', 'Food', 'Crafts'].map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                    backgroundColor: AppTheme.lightBlueGray,
                    selectedColor: AppTheme.primaryOrange,
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.white : AppTheme.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockAlert() {
    final lowStockProducts = _products.where((p) => p['stock'] < p['lowStockThreshold']).toList();
    
    if (lowStockProducts.isEmpty) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warningYellow.withOpacity(0.1),
        border: Border.all(color: AppTheme.warningYellow),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: AppTheme.warningYellow),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${lowStockProducts.length} product(s) running low on stock',
              style: AppTheme.bodyMedium.copyWith(color: AppTheme.darkGray),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final isLowStock = product['stock'] < product['lowStockThreshold'];
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    color: AppTheme.lightBlueGray,
                    child: const Icon(Icons.inventory, size: 40, color: AppTheme.gray),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isLowStock ? AppTheme.errorRed : AppTheme.successGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${product['stock']} in stock',
                      style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: AppTheme.titleMedium.copyWith(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\${product['price'].toStringAsFixed(0)}',
                        style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        color: AppTheme.primaryOrange,
                        onPressed: () => _showEditProductDialog(product),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.inventory_2, size: 20),
                        color: AppTheme.primaryOrange,
                        onPressed: () => _showStockAdjustmentDialog(product),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    String selectedCategory = 'Food';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: 'Initial Stock'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: ['Food', 'Crafts'].map((cat) {
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
                  _products.add({
                    'id': _products.length + 1,
                    'name': nameController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'stock': int.tryParse(stockController.text) ?? 0,
                    'category': selectedCategory,
                    'lowStockThreshold': 10,
                    'image': 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/03/be/f4/0e/resort.jpg',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditProductDialog(Map<String, dynamic> product) {
    final nameController = TextEditingController(text: product['name']);
    final priceController = TextEditingController(text: product['price'].toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                product['name'] = nameController.text;
                product['price'] = double.tryParse(priceController.text) ?? product['price'];
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product updated successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showStockAdjustmentDialog(Map<String, dynamic> product) {
    double stockAdjustment = 0;
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Adjust Stock: ${product['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current Stock: ${product['stock']}',
                style: AppTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Slider(
                value: stockAdjustment,
                min: -product['stock'].toDouble(),
                max: 100,
                divisions: 100 + product['stock'],
                label: stockAdjustment.toInt().toString(),
                activeColor: AppTheme.primaryOrange,
                onChanged: (value) {
                  setDialogState(() => stockAdjustment = value);
                },
              ),
              Text(
                'Adjustment: ${stockAdjustment.toInt() >= 0 ? '+' : ''}${stockAdjustment.toInt()}',
                style: AppTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'New Stock: ${product['stock'] + stockAdjustment.toInt()}',
                style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  product['stock'] = (product['stock'] + stockAdjustment.toInt()).clamp(0, 10000);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Stock updated successfully')),
                );
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrdersBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Orders', style: AppTheme.titleLarge),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  final order = _orders[index];
                  return _buildOrderCard(order);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order['customer'], style: AppTheme.titleMedium),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: order['status'] == 'pending' 
                        ? AppTheme.warningYellow 
                        : AppTheme.primaryOrange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order['status'].toUpperCase(),
                    style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...order['items'].map<Widget>((item) => Text('• $item', style: AppTheme.bodyMedium)),
            const SizedBox(height: 8),
            Text(
              'Total: \${order['total'].toStringAsFixed(2)}',
              style: AppTheme.titleMedium.copyWith(color: AppTheme.primaryOrange),
            ),
            if (order['status'] == 'pending') ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _handleOrder(order, 'cancelled'),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _handleOrder(order, 'processing'),
                    child: const Text('Process'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleOrder(Map<String, dynamic> order, String newStatus) {
    setState(() {
      order['status'] = newStatus;
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order ${newStatus}')),
    );
  }
}