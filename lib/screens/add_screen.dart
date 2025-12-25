import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'whatsapp_import_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Memory'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'How would you like to capture?',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose the best way to save your memory',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Capture Methods
              _CaptureOption(
                icon: Icons.camera_alt_rounded,
                title: 'Photo',
                description: 'Take or upload photos',
                color: AppTheme.primaryRose,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Camera feature coming soon!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _CaptureOption(
                icon: Icons.mic_rounded,
                title: 'Voice Note',
                description: 'Record your thoughts',
                color: AppTheme.accentGold,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Voice recording coming soon!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _CaptureOption(
                icon: Icons.text_fields_rounded,
                title: 'Text',
                description: 'Write it down',
                color: AppTheme.secondaryRose,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text entry coming soon!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _CaptureOption(
                icon: Icons.link_rounded,
                title: 'Link',
                description: 'Import from web or social media',
                color: const Color(0xFFB5A5D5),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link import coming soon!')),
                  );
                },
              ),
              const SizedBox(height: 16),
              _CaptureOption(
                icon: Icons.chat_rounded,
                title: 'WhatsApp Message',
                description: 'Save conversations & recommendations',
                color: const Color(0xFF25D366),
                badge: 'NEW',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WhatsAppImportScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Memory Categories
              Text(
                'Select Category',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _CategoryChip(
                    icon: Icons.restaurant_rounded,
                    label: 'Recipe',
                    color: AppTheme.primaryRose,
                  ),
                  _CategoryChip(
                    icon: Icons.place_rounded,
                    label: 'Place',
                    color: AppTheme.accentGold,
                  ),
                  _CategoryChip(
                    icon: Icons.flight_rounded,
                    label: 'Trip',
                    color: AppTheme.secondaryRose,
                  ),
                  _CategoryChip(
                    icon: Icons.child_care_rounded,
                    label: 'Kids Spot',
                    color: const Color(0xFFB5A5D5),
                  ),
                  _CategoryChip(
                    icon: Icons.local_offer_rounded,
                    label: 'Deal',
                    color: AppTheme.successGreen,
                  ),
                  _CategoryChip(
                    icon: Icons.favorite_rounded,
                    label: 'Favorite',
                    color: AppTheme.errorRose,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CaptureOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  final String? badge;

  const _CaptureOption({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.accentGold,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              badge!,
                              style: const TextStyle(
                                color: AppTheme.surfaceWhite,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      onSelected: (selected) {},
      backgroundColor: color.withValues(alpha: 0.1),
      selectedColor: color.withValues(alpha: 0.2),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
    );
  }
}
