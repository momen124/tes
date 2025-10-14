// lib/features/business/types/restaurant/screens/menu_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:easy_localization/easy_localization.dart';

class MenuManagementScreen extends ConsumerStatefulWidget {
  const MenuManagementScreen({super.key});

  @override
  ConsumerState<MenuManagementScreen> createState() =>
      _MenuManagementScreenState();
}

class _MenuManagementScreenState extends ConsumerState<MenuManagementScreen> {
  late ConfettiController _confettiController;
  final Map<String, List<Map<String, dynamic>>> _menuByCategory = {
    'Breakfast': [
      {
        'id': 1,
        'name': 'Siwa Date Pancakes',
        'price': 12.0,
        'description': 'Fluffy pancakes with dates and honey',
        'ingredients': ['Flour', 'Dates', 'Honey'],
        'isSpecial': false,
      },
    ],
    'Lunch': [
      {
        'id': 2,
        'name': 'Grilled Halloumi',
        'price': 15.0,
        'description': 'Traditional cheese with herbs',
        'ingredients': ['Halloumi', 'Herbs', 'Lemon'],
        'isSpecial': true,
      },
      {
        'id': 3,
        'name': 'Oasis Lamb Tagine',
        'price': 35.0,
        'description': 'Slow-cooked lamb with vegetables',
        'ingredients': ['Lamb', 'Vegetables', 'Spices'],
        'isSpecial': false,
      },
    ],
    'Dinner': [
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
    'Drinks': [
      {
        'id': 6,
        'name': 'Fresh Mint Tea',
        'price': 5.0,
        'description': 'Traditional Siwan mint tea',
        'ingredients': ['Mint', 'Tea', 'Sugar'],
        'isSpecial': false,
      },
    ],
  };

  int get totalItems =>
      _menuByCategory.values.fold(0, (sum, list) => sum + list.length);

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
      backgroundColor: AppTheme.lightBlueGray,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isOffline ? null : () => context.go('/business_dashboard'),
        ),
        title: Text('restaurants.view_menu'.tr()),
        backgroundColor: AppTheme.lightBlueGray,
        elevation: 0,
      ),
      body: isOffline
          ? Center(
              child: Container(
                decoration: AppTheme.offlineBanner,
                padding: const EdgeInsets.all(12),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _menuByCategory.length,
              itemBuilder: (context, index) {
                final category = _menuByCategory.keys.elementAt(index);
                final items = _menuByCategory[category]!;
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      childrenPadding: const EdgeInsets.only(bottom: 8),
                      title: Text(
                        category,
                        style: AppTheme.titleLarge.copyWith(fontSize: 20),
                      ),
                      subtitle: Text(
                        '${items.length} items',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.gray,
                        ),
                      ),
                      children: items
                          .map((item) => _buildMenuItem(item, category))
                          .toList(),
                    ),
                  ),
                ).animate().fadeIn();
              },
            ),
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: FloatingActionButton.extended(
          onPressed: isOffline ? null : _showAddMenuItem,
          backgroundColor: AppTheme.primaryOrange,
          icon: const Icon(Icons.add),
          label: Text(
            'Add Item'.tr(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item, String category) {
    final isOffline = ref.watch(offlineProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightBlueGray.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.lightBlueGray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restaurant_menu,
              size: 30,
              color: AppTheme.primaryOrange,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        style: AppTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item['isSpecial'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.warningYellow,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Special',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.gray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              color: AppTheme.primaryOrange,
              onPressed: isOffline
                  ? null
                  : () => _showEditMenuItem(item, category),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  void _showAddMenuItem() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descController = TextEditingController();
    String selectedCategory = _menuByCategory.keys.first;
    final ingredientsControllers = <TextEditingController>[
      TextEditingController(),
      TextEditingController(),
    ];
    bool isSpecial = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.gray.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add New Menu Item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'app.name'.tr(),
                              hintText: 'e.g., Grilled Lamb Chops'.tr(),
                            ),
                            validator: (value) => (value?.isEmpty ?? true)
                                ? 'Enter item name'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: descController,
                            decoration: InputDecoration(
                              labelText: 'business.listings.description'.tr(),
                              hintText: 'common.no'.tr(),
                            ),
                            maxLines: 2,
                            validator: (value) => (value?.isEmpty ?? true)
                                ? 'Enter description'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: priceController,
                                  decoration: InputDecoration(
                                    labelText: 'tourist.search.price'.tr(),
                                    prefixText: '\$ ',
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) => (value?.isEmpty ?? true)
                                      ? 'Enter price'
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  initialValue: selectedCategory,
                                  decoration: InputDecoration(
                                    labelText: 'business.listings.category'.tr(),
                                  ),
                                  items: _menuByCategory.keys.map((cat) {
                                    return DropdownMenuItem(
                                      value: cat,
                                      child: Text(cat),
                                    );
                                  }).toList(),
                                  onChanged: (value) =>
                                      setState(() => selectedCategory = value!),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...List.generate(ingredientsControllers.length, (
                            index,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: ingredientsControllers[index],
                                      decoration: InputDecoration(
                                        hintText: 'Ingredient ${index + 1}'
                                            .tr(),
                                        suffixIcon: index > 0
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: AppTheme.errorRed,
                                                ),
                                                onPressed: () {
                                                  setSheetState(
                                                    () => ingredientsControllers
                                                        .removeAt(index),
                                                  );
                                                },
                                              )
                                            : null,
                                      ),
                                      validator: (value) =>
                                          (value?.isEmpty ?? true)
                                          ? 'Enter ingredient'
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          OutlinedButton.icon(
                            onPressed: () {
                              setSheetState(
                                () => ingredientsControllers.add(
                                  TextEditingController(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.add),
                            label: Text('business.rental.vehicle_types.road'.tr()),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.primaryOrange,
                              side: const BorderSide(
                                color: AppTheme.primaryOrange,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('restaurants.specialties'.tr()),
                            subtitle: Text('Mark as today\'.tr()s special'),
                            value: isSpecial,
                            onChanged: (value) =>
                                setSheetState(() => isSpecial = value),
                            activeThumbColor: AppTheme.primaryOrange,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: AppTheme.gray.withOpacity(0.3),
                              ),
                            ),
                            child: Text('common.cancel'.tr()),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  _menuByCategory[selectedCategory]?.add({
                                    'id': DateTime.now().millisecondsSinceEpoch,
                                    'name': nameController.text,
                                    'price':
                                        double.tryParse(priceController.text) ??
                                        0.0,
                                    'description': descController.text,
                                    'ingredients': ingredientsControllers
                                        .map((c) => c.text)
                                        .where((t) => t.isNotEmpty)
                                        .toList(),
                                    'isSpecial': isSpecial,
                                  });
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Menu item added successfully'.tr(),
                                    ),
                                    backgroundColor: AppTheme.successGreen,
                                  ),
                                );
                                _confettiController.play();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: AppTheme.primaryOrange,
                            ),
                            child: Text('Add Item'.tr()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditMenuItem(Map<String, dynamic> item, String category) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: item['name']);
    final priceController = TextEditingController(
      text: item['price'].toString(),
    );
    final descController = TextEditingController(text: item['description']);
    final ingredientsControllers =
        (item['ingredients'] as List?)
            ?.map<TextEditingController>(
              (ing) => TextEditingController(text: ing),
            )
            .toList()
            .cast<TextEditingController>() ??
        [];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('common.edit'.tr()),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'app.name'.tr()),
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Enter item name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(labelText: 'business.listings.description'.tr()),
                  maxLines: 2,
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Enter description' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'tourist.search.price'.tr(),
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Enter price' : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...List.generate(ingredientsControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ingredientsControllers[index],
                            decoration: InputDecoration(
                              hintText: 'Ingredient ${index + 1}'.tr(),
                              suffixIcon: index > 0
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: AppTheme.errorRed,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () => ingredientsControllers.removeAt(
                                            index,
                                          ),
                                        );
                                      },
                                    )
                                  : null,
                            ),
                            validator: (value) => (value?.isEmpty ?? true)
                                ? 'Enter ingredient'
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(
                      () => ingredientsControllers.add(TextEditingController()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: Text('business.rental.vehicle_types.road'.tr()),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryOrange,
                    side: const BorderSide(
                      color: AppTheme.primaryOrange,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _menuByCategory[category]?.remove(item));
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('common.delete'.tr())));
              _confettiController.play();
            },
            child: Text(
              'common.delete'.tr(),
              style: TextStyle(color: AppTheme.errorRed),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  item['name'] = nameController.text;
                  item['price'] =
                      double.tryParse(priceController.text) ?? item['price'];
                  item['description'] = descController.text;
                  item['ingredients'] = ingredientsControllers
                      .map((c) => c.text)
                      .where((t) => t.isNotEmpty)
                      .toList();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menu item updated'.tr())),
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
}
