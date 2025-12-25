import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/circle.dart';
import 'circle_detail_screen.dart';
import 'create_circle_screen.dart';

class CirclesScreen extends StatefulWidget {
  const CirclesScreen({super.key});

  @override
  State<CirclesScreen> createState() => _CirclesScreenState();
}

class _CirclesScreenState extends State<CirclesScreen> {
  final List<Circle> _circles = _getDemoCircles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Circles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: _circles.isEmpty ? _buildEmptyState() : _buildCirclesList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateCircleScreen()),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Circle'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryRose.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.group_rounded,
                size: 64,
                color: AppTheme.primaryRose,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start Your First Circle',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Create circles to share memories with family, friends, or others who share your interests.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateCircleScreen()),
                );
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Create Circle'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCirclesList() {
    return CustomScrollView(
      slivers: [
        // Header with count
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.groups_rounded,
                  color: AppTheme.primaryRose,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  '${_circles.length} ${_circles.length == 1 ? 'Circle' : 'Circles'}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),

        // Circles List
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final circle = _circles[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CircleCard(
                    circle: circle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CircleDetailScreen(circle: circle),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: _circles.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  static List<Circle> _getDemoCircles() {
    final now = DateTime.now();
    return [
      Circle(
        id: '1',
        name: 'Family',
        description: 'Our family memories',
        icon: '👨‍👩‍👧‍👦',
        ownerId: 'user123',
        memberIds: ['user123', 'user456', 'user789'],
        type: CircleType.family,
        memoryCount: 47,
        createdAt: now.subtract(const Duration(days: 180)),
        lastActivityAt: now.subtract(const Duration(hours: 2)),
      ),
      Circle(
        id: '2',
        name: 'Dubai Moms',
        description: 'Best spots for kids in Dubai',
        icon: '🏙️',
        ownerId: 'user456',
        memberIds: ['user123', 'user456', 'user789', 'user101', 'user102'],
        type: CircleType.location,
        memoryCount: 89,
        createdAt: now.subtract(const Duration(days: 90)),
        lastActivityAt: now.subtract(const Duration(hours: 5)),
      ),
      Circle(
        id: '3',
        name: 'Khobar Circle',
        description: 'Hidden gems in Khobar',
        icon: '🌊',
        ownerId: 'user123',
        memberIds: ['user123', 'user456', 'user789', 'user101'],
        type: CircleType.location,
        memoryCount: 34,
        createdAt: now.subtract(const Duration(days: 60)),
        lastActivityAt: now.subtract(const Duration(days: 1)),
      ),
      Circle(
        id: '4',
        name: 'Cafe Lovers',
        description: 'Best cafes and coffee spots',
        icon: '☕',
        ownerId: 'user789',
        memberIds: ['user123', 'user456', 'user789', 'user101', 'user102', 'user103'],
        type: CircleType.interest,
        memoryCount: 67,
        createdAt: now.subtract(const Duration(days: 120)),
        lastActivityAt: now.subtract(const Duration(hours: 8)),
      ),
      Circle(
        id: '5',
        name: 'Recipe Swap',
        description: 'Quick & easy family recipes',
        icon: '🍳',
        ownerId: 'user123',
        memberIds: ['user123', 'user456', 'user789'],
        type: CircleType.interest,
        memoryCount: 52,
        createdAt: now.subtract(const Duration(days: 45)),
        lastActivityAt: now.subtract(const Duration(hours: 12)),
      ),
    ];
  }
}

class _CircleCard extends StatelessWidget {
  final Circle circle;
  final VoidCallback onTap;

  const _CircleCard({
    required this.circle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = DateTime.now().difference(circle.lastActivityAt).inHours < 24;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Circle Icon/Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: _getColorForType(circle.type).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive ? AppTheme.primaryRose : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    circle.icon ?? '👥',
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Circle Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            circle.name,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (circle.isMuted)
                          Icon(
                            Icons.notifications_off_rounded,
                            size: 16,
                            color: AppTheme.textSecondary,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (circle.description != null)
                      Text(
                        circle.description!,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.people_rounded,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${circle.memberIds.length} members',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.photo_library_rounded,
                          size: 14,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${circle.memoryCount} memories',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
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
}
