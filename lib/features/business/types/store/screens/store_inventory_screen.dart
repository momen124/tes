import 'package:siwa/data/mock_data_repository.dart';
// lib/features/business/types/store/screens/store_inventory_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

class StoreInventoryScreen extends ConsumerStatefulWidget {
  const StoreInventoryScreen({super.key});

  @override
  ConsumerState<StoreInventoryScreen> createState() =>
      _StoreInventoryScreenState();
}

class _StoreInventoryScreenState extends ConsumerState<StoreInventoryScreen> {
  late ConfettiController _confettiController;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  

  

  List<Map<String, dynamic>> get filteredProducts {
    return mockData.getAllProducts().where((product) {
      final matchesSearch =
          (product['name'] as String?)?.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ??
          false;
      final matchesCategory =
          _selectedCategory == 'All' ||
          product['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOffline = ref.watch(offlineProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isOffline ? null : () => context.go('/business_dashboard'),
        ),
        title: Text('Store Inventory'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: isOffline ? null : _showAddProductDialog,
            tooltip: 'business.dashboard.manage_products'.tr(),
          ),
        ],
      ),
      body: isOffline
          ? Center(
              child: Container(
                decoration: AppTheme.offlineBanner,
                padding: const EdgeInsets.all(16),
                child: Text('common.offline'.tr(), style: AppTheme.bodyMedium),
              ),
            )
          : Column(
              children: [
                _buildSearchAndFilter().animate().fadeIn(),
                _buildLowStockAlert().animate().fadeIn(),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width > 600
                          ? 3
                          : 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductCard(product).animate().fadeIn();
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: isOffline ? null : _showOrdersBottomSheet,
        icon: const Icon(Icons.receipt_long),
        label: Text('Orders (${mockData.getAllOther().length})'.tr()),
        backgroundColor: isOffline ? AppTheme.gray : AppTheme.primaryOrange,
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
              hintText: 'navigation.search'.tr(),
              prefixIcon: const Icon(
                Icons.search,
                color: AppTheme.primaryOrange,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppTheme.secondaryGray.withOpacity(0.3),
                ),
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
    final lowStockProducts = mockData.getAllProducts()
        .where((p) {
          final stock = p['stock'] as int? ?? 0;
          final threshold = p['lowStockThreshold'] as int? ?? 0;
          return stock < threshold;
        })
        .toList();

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
final isLowStock = (product['stock'] as int? ?? 0) < (product['lowStockThreshold'] as int? ?? 0);
    final isOffline = ref.watch(offlineProvider);

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
                    child: const Icon(
                      Icons.inventory,
                      size: 40,
                      color: AppTheme.gray,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isLowStock
                          ? AppTheme.errorRed
                          : AppTheme.successGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${product['stock'] == true ?? 0} in stock',
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
                        "\$${(product['price'] as double?)?.toStringAsFixed(0) ?? '0'}",
                        style: AppTheme.titleMedium.copyWith(
                          color: AppTheme.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        color: AppTheme.primaryOrange,
                        onPressed: isOffline
                            ? null
                            : () => _showEditProductDialog(product),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.inventory_2, size: 20),
                        color: AppTheme.primaryOrange,
                        onPressed: isOffline
                            ? null
                            : () => _showStockAdjustmentDialog(product),
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
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final stockController = TextEditingController();
    String selectedCategory = 'Food';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('business.dashboard.manage_products'.tr()),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'transportation.route'.tr()),
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Enter product name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'tourist.search.price'.tr()),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Enter price' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: stockController,
                  decoration: InputDecoration(labelText: 'Initial Stock'.tr()),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Enter stock' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: InputDecoration(labelText: 'business.listings.category'.tr()),
                  items: ['Food', 'Crafts'].map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (value) => selectedCategory = value!,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  mockData.getAllProducts().add({
                    'id': mockData.getAllProducts().length + 1,
                    'name': nameController.text,
                    'price': double.tryParse(priceController.text) ?? 0.0,
                    'stock': int.tryParse(stockController.text) ?? 0,
                    'category': selectedCategory,
                    'lowStockThreshold': 10,
                    'image':
                        'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=300&fit=crop',
                  });
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product added successfully'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('business.rental.vehicle_types.road'.tr()),
          ),
        ],
      ),
    );
  }

  void _showEditProductDialog(Map<String, dynamic> product) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: product['name']);
    final priceController = TextEditingController(
      text: (product['price'] as double?)?.toString() ?? '0',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('common.edit'.tr()),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'transportation.route'.tr()),
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Enter product name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'tourist.search.price'.tr()),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Enter price' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  product['name'] = nameController.text;
                  product['price'] =
                      double.tryParse(priceController.text) ?? product['price'];
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product updated successfully'.tr())),
                );
                _confettiController.play();
              }
            },
            child: Text('common.save'.tr()),
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
          title: Text('Adjust Stock: ${product['.tr()name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current Stock: ${product['stock'] == true ?? 0}',
                style: AppTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              Slider(
                value: stockAdjustment,
                min: -((product['stock'] as int? ?? 0).toDouble()),
                max: 100.0,
                divisions: 100 + (product['stock'] as int? ?? 0),
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
                'New Stock: ${product['stock'] == true ?? 0 + stockAdjustment.toInt()}',
                style: AppTheme.titleMedium.copyWith(
                  color: AppTheme.primaryOrange,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('common.cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  product['stock'] =
                      (product['stock'] + stockAdjustment.toInt()).clamp(
                        0,
                        10000,
                      );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Stock updated successfully'.tr())),
                );
                _confettiController.play();
              },
              child: Text('tourist.booking.date'.tr()),
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
                  Text('business.rental.vehicle_types.others'.tr(), style: AppTheme.titleLarge),
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
                itemCount: mockData.getAllOther().length,
                itemBuilder: (context, index) {
                  final order = mockData.getAllOther()[index];
                  return _buildOrderCard(order).animate().fadeIn();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final isOffline = ref.watch(offlineProvider);

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: order['status'] == 'pending'
                        ? AppTheme.warningYellow
                        : AppTheme.primaryOrange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    (order['status'] as String?)?.toUpperCase() ?? 'UNKNOWN',
                    style: AppTheme.bodySmall.copyWith(color: AppTheme.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...(order['items'] as List?)?.map<Widget>(
                  (item) => Text('• $item'.tr(), style: AppTheme.bodyMedium),
                ) ??
                [],
            const SizedBox(height: 8),
            Text(
              "Total: \$${(order['total'] as double?)?.toStringAsFixed(2) ?? '0.00'}",
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.primaryOrange,
              ),
            ),
            if (order['status'] == 'pending') ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: isOffline
                        ? null
                        : () => _handleOrder(order, 'cancelled'),
                    child: Text('common.cancel'.tr()),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isOffline
                        ? null
                        : () => _handleOrder(order, 'processing'),
                    child: Text('tourist.search.price'.tr()),
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Order $newStatus'.tr())));
    _confettiController.play();
  }
}
