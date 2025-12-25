import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/circle.dart';
import '../models/memory.dart';
import '../widgets/circle_memory_card.dart';

class CircleDetailScreen extends StatefulWidget {
  final Circle circle;

  const CircleDetailScreen({super.key, required this.circle});

  @override
  State<CircleDetailScreen> createState() => _CircleDetailScreenState();
}

class _CircleDetailScreenState extends State<CircleDetailScreen> {
  final List<Memory> _memories = _getDemoMemories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Circle Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.circle.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getColorForType(widget.circle.type),
                      _getColorForType(widget.circle.type).withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.circle.icon ?? '👥',
                    style: const TextStyle(fontSize: 64),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                onPressed: () => _showCircleOptions(context),
              ),
            ],
          ),

          // Circle Info
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: AppTheme.shadowColor,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.circle.description != null) ...[
                    Text(
                      widget.circle.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.people_rounded,
                        label: '${widget.circle.memberIds.length} members',
                      ),
                      const SizedBox(width: 12),
                      _InfoChip(
                        icon: Icons.photo_library_rounded,
                        label: '${widget.circle.memoryCount} memories',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_rounded),
                    label: const Text('Invite Friends'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primaryRose,
                      side: const BorderSide(color: AppTheme.primaryRose),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Memories Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shared Memories',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Memories List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final memory = _memories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CircleMemoryCard(
                      memory: memory,
                      circleId: widget.circle.id,
                      sharedByName: 'Sarah Ahmed',
                      onSaveToVault: () => _saveToVault(memory),
                      onReact: (reaction) => _addReaction(memory, reaction),
                      onComment: () => _showComments(memory),
                    ),
                  );
                },
                childCount: _memories.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _shareMemoryToCircle(),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Color _getColorForType(CircleType type) {
    switch (type) {
      case CircleType.family:
        return AppTheme.primaryRose;
      case CircleType.friends:
        return AppTheme.accentGold;
      case CircleType.location:
        return const Color(0xFFB5A5D5);
      case CircleType.interest:
        return AppTheme.successGreen;
      case CircleType.custom:
        return AppTheme.secondaryRose;
    }
  }

  void _showCircleOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_rounded),
              title: const Text('Edit Circle'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_rounded),
              title: const Text('Manage Members'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                widget.circle.isMuted
                    ? Icons.notifications_active_rounded
                    : Icons.notifications_off_rounded,
              ),
              title: Text(widget.circle.isMuted ? 'Unmute' : 'Mute'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text('Leave Circle'),
              textColor: AppTheme.errorRose,
              iconColor: AppTheme.errorRose,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _shareMemoryToCircle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share memory to circle - coming soon!')),
    );
  }

  void _saveToVault(Memory memory) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved "${memory.title}" to your vault!')),
    );
  }

  void _addReaction(Memory memory, ReactionType reaction) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reacted with ${reaction.emoji} ${reaction.label}')),
    );
  }

  void _showComments(Memory memory) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _CommentsSheet(
          memory: memory,
          scrollController: scrollController,
        ),
      ),
    );
  }

  static List<Memory> _getDemoMemories() {
    final now = DateTime.now();
    return [
      Memory(
        id: '1',
        type: MemoryType.place,
        title: 'The Spot Cafe',
        description: 'Amazing brunch! Try their avocado toast and flat white.',
        photos: ['https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800'],
        location: 'Al Khobar Corniche',
        tags: ['cafe', 'brunch', 'ocean-view'],
        createdAt: now.subtract(const Duration(hours: 3)),
        updatedAt: now.subtract(const Duration(hours: 3)),
        userId: 'user456',
        rating: 5.0,
      ),
      Memory(
        id: '2',
        type: MemoryType.recipe,
        title: 'Quick Chicken Shawarma',
        description: 'Ready in 20 minutes! Kids love it.',
        photos: ['https://images.unsplash.com/photo-1529006557810-274b9b2fc783?w=800'],
        tags: ['quick', 'dinner', 'kid-friendly'],
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
        userId: 'user789',
        rating: 4.5,
      ),
    ];
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryRose.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryRose),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.primaryRose,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentsSheet extends StatelessWidget {
  final Memory memory;
  final ScrollController scrollController;

  const _CommentsSheet({
    required this.memory,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final demoComments = [
      Comment(
        userId: 'user1',
        userName: 'Fatima Al-Rashid',
        text: 'Looks amazing! Adding to my must-try list 😋',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Comment(
        userId: 'user2',
        userName: 'Noor Ahmed',
        text: 'We went there last week, the kids loved it!',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundWarm,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.dividerLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comments',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  '${demoComments.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ),
              ],
            ),
          ),

          // Comments List
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: demoComments.length,
              itemBuilder: (context, index) {
                final comment = demoComments[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppTheme.primaryRose,
                        child: Text(
                          comment.userName[0],
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
                              comment.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              comment.text,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatTimestamp(comment.timestamp),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Comment Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.surfaceWhite,
              border: Border(top: BorderSide(color: AppTheme.dividerLight)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: AppTheme.primaryRose,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
