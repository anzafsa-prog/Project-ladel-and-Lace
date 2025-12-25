import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/memory.dart';
import '../models/circle.dart';

class CircleMemoryCard extends StatelessWidget {
  final Memory memory;
  final String circleId;
  final String sharedByName;
  final VoidCallback onSaveToVault;
  final Function(ReactionType) onReact;
  final VoidCallback onComment;

  const CircleMemoryCard({
    super.key,
    required this.memory,
    required this.circleId,
    required this.sharedByName,
    required this.onSaveToVault,
    required this.onReact,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shared By Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppTheme.primaryRose,
                  child: Text(
                    sharedByName[0],
                    style: const TextStyle(
                      color: AppTheme.surfaceWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sharedByName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _formatDate(memory.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                _TypeBadge(type: memory.type),
              ],
            ),
          ),

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
                // Title
                Text(
                  memory.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                // Description
                if (memory.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    memory.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                // Location & Rating
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (memory.rating != null) ...[
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
                            ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    if (memory.location != null) ...[
                      Icon(
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
                  ],
                ),

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

                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 12),

                // Reaction Bar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ReactionType.values.map((reaction) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _ReactionButton(
                          reaction: reaction,
                          count: _getDemoCount(reaction),
                          isSelected: false,
                          onTap: () => onReact(reaction),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onSaveToVault,
                        icon: const Icon(Icons.bookmark_add_rounded, size: 18),
                        label: const Text('Save to Vault'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primaryRose,
                          side: const BorderSide(color: AppTheme.primaryRose),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: onComment,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.textSecondary,
                        side: const BorderSide(color: AppTheme.dividerLight),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.comment_rounded, size: 18),
                          const SizedBox(width: 8),
                          Text('${_getDemoCommentCount()}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inHours < 1) return '${difference.inMinutes}m ago';
    if (difference.inDays < 1) return '${difference.inHours}h ago';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${(difference.inDays / 7).floor()}w ago';
  }

  int _getDemoCount(ReactionType reaction) {
    // Demo counts
    switch (reaction) {
      case ReactionType.yum:
        return 12;
      case ReactionType.mustTry:
        return 8;
      case ReactionType.kidApproved:
        return 5;
      case ReactionType.worthIt:
        return 3;
      case ReactionType.tooCrowded:
        return 1;
      case ReactionType.love:
        return 15;
    }
  }

  int _getDemoCommentCount() => 3;
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  final ReactionType reaction;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReactionButton({
    required this.reaction,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryRose.withValues(alpha: 0.1)
              : AppTheme.dividerLight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryRose : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              reaction.emoji,
              style: const TextStyle(fontSize: 16),
            ),
            if (count > 0) ...[
              const SizedBox(width: 6),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppTheme.primaryRose : AppTheme.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
