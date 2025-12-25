enum MemoryType {
  recipe,
  place,
  trip,
  kids,
  deal,
  favorite,
}

class Memory {
  final String id;
  final MemoryType type;
  final String title;
  final String? description;
  final List<String> photos;
  final String? voiceNote;
  final String? location;
  final Map<String, dynamic> metadata;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;
  final bool isPrivate;
  final double? rating;

  Memory({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    this.photos = const [],
    this.voiceNote,
    this.location,
    this.metadata = const {},
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.isPrivate = true,
    this.rating,
  });

  factory Memory.fromMap(Map<String, dynamic> map, String id) {
    return Memory(
      id: id,
      type: MemoryType.values.firstWhere(
        (e) => e.toString() == 'MemoryType.${map['type']}',
        orElse: () => MemoryType.favorite,
      ),
      title: map['title'] ?? '',
      description: map['description'],
      photos: List<String>.from(map['photos'] ?? []),
      voiceNote: map['voiceNote'],
      location: map['location'],
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      tags: List<String>.from(map['tags'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      userId: map['userId'] ?? '',
      isPrivate: map['isPrivate'] ?? true,
      rating: map['rating']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.toString().split('.').last,
      'title': title,
      'description': description,
      'photos': photos,
      'voiceNote': voiceNote,
      'location': location,
      'metadata': metadata,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
      'isPrivate': isPrivate,
      'rating': rating,
    };
  }

  Memory copyWith({
    String? title,
    String? description,
    List<String>? photos,
    String? voiceNote,
    String? location,
    Map<String, dynamic>? metadata,
    List<String>? tags,
    bool? isPrivate,
    double? rating,
  }) {
    return Memory(
      id: id,
      type: type,
      title: title ?? this.title,
      description: description ?? this.description,
      photos: photos ?? this.photos,
      voiceNote: voiceNote ?? this.voiceNote,
      location: location ?? this.location,
      metadata: metadata ?? this.metadata,
      tags: tags ?? this.tags,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      userId: userId,
      isPrivate: isPrivate ?? this.isPrivate,
      rating: rating ?? this.rating,
    );
  }
}

// Recipe-specific model
class Recipe extends Memory {
  final List<String> ingredients;
  final List<String> steps;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String difficulty;
  final int madeAgainCount;

  Recipe({
    required super.id,
    required super.title,
    super.description,
    super.photos,
    super.metadata,
    super.tags,
    required super.createdAt,
    required super.updatedAt,
    required super.userId,
    super.isPrivate,
    super.rating,
    this.ingredients = const [],
    this.steps = const [],
    this.prepTime = 0,
    this.cookTime = 0,
    this.servings = 1,
    this.difficulty = 'Medium',
    this.madeAgainCount = 0,
  }) : super(type: MemoryType.recipe);

  factory Recipe.fromMap(Map<String, dynamic> map, String id) {
    return Recipe(
      id: id,
      title: map['title'] ?? '',
      description: map['description'],
      photos: List<String>.from(map['photos'] ?? []),
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      tags: List<String>.from(map['tags'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      userId: map['userId'] ?? '',
      isPrivate: map['isPrivate'] ?? true,
      rating: map['rating']?.toDouble(),
      ingredients: List<String>.from(map['ingredients'] ?? []),
      steps: List<String>.from(map['steps'] ?? []),
      prepTime: map['prepTime'] ?? 0,
      cookTime: map['cookTime'] ?? 0,
      servings: map['servings'] ?? 1,
      difficulty: map['difficulty'] ?? 'Medium',
      madeAgainCount: map['madeAgainCount'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'ingredients': ingredients,
      'steps': steps,
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'difficulty': difficulty,
      'madeAgainCount': madeAgainCount,
    });
    return map;
  }
}

// Place-specific model
class Place extends Memory {
  final String? address;
  final double? latitude;
  final double? longitude;
  final String priceRange;
  final bool kidFriendly;
  final bool halalFriendly;
  final bool hasParking;
  final bool strollerFriendly;
  final String? bestItems;
  final String? openingHours;

  Place({
    required super.id,
    required super.title,
    super.description,
    super.photos,
    super.location,
    super.metadata,
    super.tags,
    required super.createdAt,
    required super.updatedAt,
    required super.userId,
    super.isPrivate,
    super.rating,
    this.address,
    this.latitude,
    this.longitude,
    this.priceRange = '\$\$',
    this.kidFriendly = false,
    this.halalFriendly = false,
    this.hasParking = false,
    this.strollerFriendly = false,
    this.bestItems,
    this.openingHours,
  }) : super(type: MemoryType.place);

  factory Place.fromMap(Map<String, dynamic> map, String id) {
    return Place(
      id: id,
      title: map['title'] ?? '',
      description: map['description'],
      photos: List<String>.from(map['photos'] ?? []),
      location: map['location'],
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
      tags: List<String>.from(map['tags'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
      userId: map['userId'] ?? '',
      isPrivate: map['isPrivate'] ?? true,
      rating: map['rating']?.toDouble(),
      address: map['address'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      priceRange: map['priceRange'] ?? '\$\$',
      kidFriendly: map['kidFriendly'] ?? false,
      halalFriendly: map['halalFriendly'] ?? false,
      hasParking: map['hasParking'] ?? false,
      strollerFriendly: map['strollerFriendly'] ?? false,
      bestItems: map['bestItems'],
      openingHours: map['openingHours'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'priceRange': priceRange,
      'kidFriendly': kidFriendly,
      'halalFriendly': halalFriendly,
      'hasParking': hasParking,
      'strollerFriendly': strollerFriendly,
      'bestItems': bestItems,
      'openingHours': openingHours,
    });
    return map;
  }
}
