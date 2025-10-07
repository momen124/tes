import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Corrected import
import 'package:siwa/providers/offline_provider.dart';

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
          const Text('Offline - Sync Later', style: TextStyle(color: Colors.white)),
          ElevatedButton(onPressed: () {}, child: const Text('Sync'), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFF7518))),
        ],
      ),
    );
  }
}