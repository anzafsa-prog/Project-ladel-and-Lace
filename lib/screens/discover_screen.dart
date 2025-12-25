import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/memory.dart';
import '../widgets/memory_card.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Location Header
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryRose.withValues(alpha: 0.2),
                    AppTheme.secondaryRose.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: AppTheme.primaryRose,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trending in Dubai',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'Discover what\'s popular in your city',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune_rounded),
                    color: AppTheme.primaryRose,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: _selectedFilter == 'All',
                    onTap: () => setState(() => _selectedFilter = 'All'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Recipes',
                    isSelected: _selectedFilter == 'Recipes',
                    onTap: () => setState(() => _selectedFilter = 'Recipes'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Places',
                    isSelected: _selectedFilter == 'Places',
                    onTap: () => setState(() => _selectedFilter = 'Places'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Kids',
                    isSelected: _selectedFilter == 'Kids',
                    onTap: () => setState(() => _selectedFilter = 'Kids'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Trips',
                    isSelected: _selectedFilter == 'Trips',
                    onTap: () => setState(() => _selectedFilter = 'Trips'),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Trending Collections
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Trending Collections',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // Collections List
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _CollectionCard(
                    title: [
                      'Best Cafes in Marina',
                      'Quick Dinner Recipes',
                      'Family-Friendly Parks'
                    ][index],
                    itemCount: [12, 8, 15][index],
                    imageUrl: [
                      'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
                      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=400',
                      'https://images.unsplash.com/photo-1587564408617-dfff933c8580?w=400',
                    ][index],
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Popular Near You
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Near You',
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

          const SliverToBoxAdapter(child: SizedBox(height: 12)),

          // Popular Memories
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final memories = _getPopularMemories();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MemoryCard(memory: memories[index]),
                  );
                },
                childCount: 2,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  List<Memory> _getPopularMemories() {
    final now = DateTime.now();
    return [
      Memory(
        id: '1',
        type: MemoryType.place,
        title: 'Le Pain Quotidien',
        description: 'Perfect brunch spot with outdoor seating. Kids menu available!',
        photos: ['https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800'],
        location: 'JBR, Dubai',
        tags: ['brunch', 'family-friendly', 'outdoor'],
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
        userId: 'user123',
        rating: 4.8,
      ),
      Memory(
        id: '2',
        type: MemoryType.recipe,
        title: 'No-Bake Cheesecake',
        description: 'Easy, quick dessert that\'s always a hit at gatherings!',
        photos: ['https://images.unsplash.com/photo-1524351199678-941a58a3df50?w=800'],
        tags: ['dessert', 'no-bake', 'easy'],
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
        userId: 'user456',
        rating: 5.0,
      ),
    ];
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryRose : AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppTheme.primaryRose : AppTheme.dividerLight,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.surfaceWhite : AppTheme.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final String title;
  final int itemCount;
  final String imageUrl;

  const _CollectionCard({
    required this.title,
    required this.itemCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.dividerLight,
                      child: const Center(
                        child: Icon(Icons.image_not_supported_rounded),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2_rounded,
                          size: 16,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$itemCount items',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.favorite_rounded,
                          size: 16,
                          color: AppTheme.primaryRose,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${itemCount * 8}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
