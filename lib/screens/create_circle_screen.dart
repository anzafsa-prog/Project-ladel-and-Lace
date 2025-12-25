import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/circle.dart';

class CreateCircleScreen extends StatefulWidget {
  const CreateCircleScreen({super.key});

  @override
  State<CreateCircleScreen> createState() => _CreateCircleScreenState();
}

class _CreateCircleScreenState extends State<CreateCircleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedIcon = '👥';
  CircleType _selectedType = CircleType.custom;

  final List<String> _emojiIcons = [
    '👥', '👨‍👩‍👧‍👦', '👯‍♀️', '🏙️', '🌊', '☕', '🍳', 
    '🎨', '📚', '🎪', '🏃‍♀️', '🧘‍♀️', '🛍️', '✈️', '🎉'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Circle'),
        actions: [
          TextButton(
            onPressed: _createCircle,
            child: const Text('Create'),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Icon Selector
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _getColorForType(_selectedType).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getColorForType(_selectedType),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _selectedIcon,
                          style: const TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Choose Icon',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: _emojiIcons.map((emoji) {
                        final isSelected = emoji == _selectedIcon;
                        return InkWell(
                          onTap: () => setState(() => _selectedIcon = emoji),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryRose.withValues(alpha: 0.1)
                                  : AppTheme.dividerLight,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primaryRose
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(emoji, style: const TextStyle(fontSize: 28)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Circle Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Circle Name',
                  hintText: 'e.g., Dubai Moms, Cafe Lovers',
                  prefixIcon: Icon(Icons.label_rounded),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a circle name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  hintText: 'What is this circle about?',
                  prefixIcon: Icon(Icons.description_rounded),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 24),

              // Circle Type
              Text(
                'Circle Type',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _TypeChip(
                    type: CircleType.family,
                    label: 'Family',
                    icon: Icons.family_restroom_rounded,
                    isSelected: _selectedType == CircleType.family,
                    onTap: () => setState(() => _selectedType = CircleType.family),
                  ),
                  _TypeChip(
                    type: CircleType.friends,
                    label: 'Friends',
                    icon: Icons.people_rounded,
                    isSelected: _selectedType == CircleType.friends,
                    onTap: () => setState(() => _selectedType = CircleType.friends),
                  ),
                  _TypeChip(
                    type: CircleType.location,
                    label: 'Location',
                    icon: Icons.location_city_rounded,
                    isSelected: _selectedType == CircleType.location,
                    onTap: () => setState(() => _selectedType = CircleType.location),
                  ),
                  _TypeChip(
                    type: CircleType.interest,
                    label: 'Interest',
                    icon: Icons.interests_rounded,
                    isSelected: _selectedType == CircleType.interest,
                    onTap: () => setState(() => _selectedType = CircleType.interest),
                  ),
                  _TypeChip(
                    type: CircleType.custom,
                    label: 'Custom',
                    icon: Icons.star_rounded,
                    isSelected: _selectedType == CircleType.custom,
                    onTap: () => setState(() => _selectedType = CircleType.custom),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryRose.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryRose.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppTheme.primaryRose,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'You can invite friends to your circle after creating it.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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

  void _createCircle() {
    if (_formKey.currentState!.validate()) {
      // TODO: Create circle in Firebase
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Circle "${_nameController.text}" created!'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
    }
  }
}

class _TypeChip extends StatelessWidget {
  final CircleType type;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getColorForType(type);

    return FilterChip(
      selected: isSelected,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: isSelected ? color : AppTheme.textSecondary),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      onSelected: (_) => onTap(),
      backgroundColor: color.withValues(alpha: 0.05),
      selectedColor: color.withValues(alpha: 0.15),
      side: BorderSide(
        color: isSelected ? color : AppTheme.dividerLight,
        width: isSelected ? 2 : 1,
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
