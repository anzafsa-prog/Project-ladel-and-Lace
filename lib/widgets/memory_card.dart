import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/memory.dart';

class MemoryCard extends StatelessWidget {
  final Memory memory;

  const MemoryCard({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to memory detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (memory.photos.isNotEmpty)
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  memory.photos.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.dividerLight,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: AppTheme.textSecondary,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Type Badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          memory.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _TypeBadge(type: memory.type),
                    ],
                  ),

                  // Description
                  if (memory.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      memory.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  // Rating
                  if (memory.rating != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: AppTheme.accentGold,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          memory.rating!.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                        ),
                      ],
                    ),
                  ],

                  // Tags
                  if (memory.tags.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: memory.tags.take(3).map((tag) {
                        return Chip(
                          label: Text(tag),
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),
                  ],

                  // Location
                  if (memory.location != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.place_rounded,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            memory.location!,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Footer: Date and Actions
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(memory.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_border_rounded),
                            iconSize: 20,
                            color: AppTheme.textSecondary,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.share_rounded),
                            iconSize: 20,
                            color: AppTheme.textSecondary,
                            onPressed: () {},
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }
  }
}

class _TypeBadge extends StatelessWidget {
  final MemoryType type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (type) {
      case MemoryType.recipe:
        icon = Icons.restaurant_rounded;
        color = AppTheme.primaryRose;
        break;
      case MemoryType.place:
        icon = Icons.place_rounded;
        color = AppTheme.accentGold;
        break;
      case MemoryType.trip:
        icon = Icons.flight_rounded;
        color = AppTheme.secondaryRose;
        break;
      case MemoryType.kids:
        icon = Icons.child_care_rounded;
        color = const Color(0xFFB5A5D5);
        break;
      case MemoryType.deal:
        icon = Icons.local_offer_rounded;
        color = AppTheme.successGreen;
        break;
      case MemoryType.favorite:
        icon = Icons.favorite_rounded;
        color = AppTheme.errorRose;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: color),
    );
  }
}
