import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../widgets/memory_card.dart';
import '../models/memory.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Memory> _recentMemories = _getDemoMemories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              backgroundColor: AppTheme.backgroundWarm,
              elevation: 0,
              title: Row(
                children: [
                  Image.asset(
                    'assets/icons/app_icon.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Cherish',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    icon: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.primaryRose,
                      child: const Text(
                        'S',
                        style: TextStyle(
                          color: AppTheme.surfaceWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Greeting Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, Sarah',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Capture today\'s beautiful moments',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            // Quick Actions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.restaurant_rounded,
                        label: 'Recipe',
                        color: AppTheme.primaryRose,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.place_rounded,
                        label: 'Place',
                        color: AppTheme.accentGold,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.flight_rounded,
                        label: 'Trip',
                        color: AppTheme.secondaryRose,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Recent Memories Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Memories',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
            ),

            // Memories Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final memory = _recentMemories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: MemoryCard(memory: memory),
                    );
                  },
                  childCount: _recentMemories.length,
                ),
              ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.camera_alt_rounded, size: 28),
      ),
    );
  }

  static List<Memory> _getDemoMemories() {
    final now = DateTime.now();
    return [
      Memory(
        id: '1',
        type: MemoryType.recipe,
        title: 'Chocolate Chip Cookies',
        description: 'Perfect crispy-chewy cookies that everyone loves!',
        photos: ['https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=800'],
        tags: ['dessert', 'baking', 'quick'],
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
        userId: 'demo',
        rating: 4.5,
      ),
      Memory(
        id: '2',
        type: MemoryType.place,
        title: 'The Coffee Club',
        description: 'Amazing flat white and cozy atmosphere. Perfect for morning catch-ups!',
        photos: ['https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800'],
        location: 'Dubai Marina Mall',
        tags: ['cafe', 'coffee', 'breakfast'],
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
        userId: 'demo',
        rating: 5.0,
      ),
      Memory(
        id: '3',
        type: MemoryType.kids,
        title: 'Bounce Dubai',
        description: 'Kids had an amazing time! Great for 5+ years. Book morning slots for less crowds.',
        photos: ['https://images.unsplash.com/photo-1587564408617-dfff933c8580?w=800'],
        location: 'Al Quoz',
        tags: ['kids', 'indoor', 'active'],
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
        userId: 'demo',
        rating: 4.0,
      ),
    ];
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
