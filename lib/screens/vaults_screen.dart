import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/memory.dart';

class VaultsScreen extends StatefulWidget {
  const VaultsScreen({super.key});

  @override
  State<VaultsScreen> createState() => _VaultsScreenState();
}

class _VaultsScreenState extends State<VaultsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vaults'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.primaryRose,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryRose,
          tabs: const [
            Tab(
              icon: Icon(Icons.restaurant_rounded),
              text: 'Recipes',
            ),
            Tab(
              icon: Icon(Icons.place_rounded),
              text: 'Places',
            ),
            Tab(
              icon: Icon(Icons.flight_rounded),
              text: 'Trips',
            ),
            Tab(
              icon: Icon(Icons.child_care_rounded),
              text: 'Kids',
            ),
            Tab(
              icon: Icon(Icons.local_offer_rounded),
              text: 'Deals',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _VaultTab(
            type: MemoryType.recipe,
            emptyMessage: 'No recipes saved yet',
            emptyIcon: Icons.restaurant_rounded,
          ),
          _VaultTab(
            type: MemoryType.place,
            emptyMessage: 'No places saved yet',
            emptyIcon: Icons.place_rounded,
          ),
          _VaultTab(
            type: MemoryType.trip,
            emptyMessage: 'No trips saved yet',
            emptyIcon: Icons.flight_rounded,
          ),
          _VaultTab(
            type: MemoryType.kids,
            emptyMessage: 'No kids spots saved yet',
            emptyIcon: Icons.child_care_rounded,
          ),
          _VaultTab(
            type: MemoryType.deal,
            emptyMessage: 'No deals saved yet',
            emptyIcon: Icons.local_offer_rounded,
          ),
        ],
      ),
    );
  }
}

class _VaultTab extends StatelessWidget {
  final MemoryType type;
  final String emptyMessage;
  final IconData emptyIcon;

  const _VaultTab({
    required this.type,
    required this.emptyMessage,
    required this.emptyIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Demo data - in production, this would come from Firebase
    final List<Memory> memories = _getDemoMemories(type);

    if (memories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              emptyIcon,
              size: 64,
              color: AppTheme.dividerLight,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add First Memory'),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        // Filter Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search_rounded),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.filter_list_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.surfaceWhite,
                    padding: const EdgeInsets.all(12),
                  ),
                  onPressed: () {
                    // Show filter bottom sheet
                  },
                ),
              ],
            ),
          ),
        ),

        // Stats Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _StatCard(
                  label: 'Total',
                  value: memories.length.toString(),
                  icon: Icons.inventory_2_rounded,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'This Month',
                  value: memories.where((m) {
                    final diff = DateTime.now().difference(m.createdAt).inDays;
                    return diff < 30;
                  }).length.toString(),
                  icon: Icons.calendar_today_rounded,
                ),
                const SizedBox(width: 12),
                _StatCard(
                  label: 'Favorites',
                  value: memories.where((m) => m.rating != null && m.rating! >= 4.5).length.toString(),
                  icon: Icons.star_rounded,
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // Memories List
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final memory = memories[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CompactMemoryCard(memory: memory),
                );
              },
              childCount: memories.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  List<Memory> _getDemoMemories(MemoryType type) {
    final now = DateTime.now();
    
    switch (type) {
      case MemoryType.recipe:
        return [
          Memory(
            id: '1',
            type: MemoryType.recipe,
            title: 'Chocolate Chip Cookies',
            description: 'Perfect crispy-chewy cookies',
            photos: ['https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400'],
            tags: ['dessert', 'baking'],
            createdAt: now.subtract(const Duration(days: 2)),
            updatedAt: now.subtract(const Duration(days: 2)),
            userId: 'demo',
            rating: 4.5,
          ),
          Memory(
            id: '2',
            type: MemoryType.recipe,
            title: 'Chicken Biryani',
            description: 'Authentic Hyderabadi style',
            photos: ['https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=400'],
            tags: ['dinner', 'spicy', 'rice'],
            createdAt: now.subtract(const Duration(days: 7)),
            updatedAt: now.subtract(const Duration(days: 7)),
            userId: 'demo',
            rating: 5.0,
          ),
        ];
      case MemoryType.place:
        return [
          Memory(
            id: '3',
            type: MemoryType.place,
            title: 'The Coffee Club',
            description: 'Amazing flat white and cozy atmosphere',
            photos: ['https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400'],
            location: 'Dubai Marina Mall',
            tags: ['cafe', 'coffee'],
            createdAt: now.subtract(const Duration(days: 5)),
            updatedAt: now.subtract(const Duration(days: 5)),
            userId: 'demo',
            rating: 5.0,
          ),
        ];
      default:
        return [];
    }
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryRose, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactMemoryCard extends StatelessWidget {
  final Memory memory;

  const _CompactMemoryCard({required this.memory});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: memory.photos.isNotEmpty
                    ? Image.network(
                        memory.photos.first,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: AppTheme.dividerLight,
                            child: const Icon(Icons.image_not_supported_rounded),
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: AppTheme.dividerLight,
                        child: Icon(
                          _getIconForType(memory.type),
                          color: AppTheme.textSecondary,
                        ),
                      ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memory.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (memory.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        memory.description!,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (memory.rating != null) ...[
                          Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: AppTheme.accentGold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            memory.rating!.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 12),
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
                  ],
                ),
              ),

              // Arrow
              const Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(MemoryType type) {
    switch (type) {
      case MemoryType.recipe:
        return Icons.restaurant_rounded;
      case MemoryType.place:
        return Icons.place_rounded;
      case MemoryType.trip:
        return Icons.flight_rounded;
      case MemoryType.kids:
        return Icons.child_care_rounded;
      case MemoryType.deal:
        return Icons.local_offer_rounded;
      case MemoryType.favorite:
        return Icons.favorite_rounded;
    }
  }
}
