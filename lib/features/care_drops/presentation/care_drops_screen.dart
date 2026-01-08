import 'package:flutter/material.dart';
import '../../../core/widgets/widgets.dart';

/// Care Drops placeholder screen
class CareDropsScreen extends StatelessWidget {
  const CareDropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedBackground(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const GradientText(
                    text: 'Care Drops',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Content placeholder
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // QR code placeholder
                    GlowContainer(
                      borderRadius: 16,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.qr_code_2,
                            size: 80,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Scan to Connect',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    PastelCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            '1:1 Support',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'QR-based messaging for personal care connections',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
