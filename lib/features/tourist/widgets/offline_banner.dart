import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siwa/features/tourist/providers/offline_provider.dart'; // Corrected import
import 'package:easy_localization/easy_localization.dart';

class OfflineBanner extends ConsumerWidget { // Changed from ConsumerWidget to ConsumerWidget
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offline = ref.watch(offlineProvider);
    if (!offline) return const SizedBox.shrink();
    return Container(
      color: const Color(0xFF808080),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Offline - Sync Later'.tr(), style: TextStyle(color: Colors.white)),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF7518)), child: Text('Sync'.tr())),
        ],
      ),
    );
  }
}