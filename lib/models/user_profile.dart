class UserProfile {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? city;
  final List<String> interests;
  final Map<String, int> stats;
  final String theme;
  final String language;
  final bool isPremium;
  final DateTime createdAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.city,
    this.interests = const [],
    this.stats = const {},
    this.theme = 'roseGold',
    this.language = 'en',
    this.isPremium = false,
    required this.createdAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map, String id) {
    return UserProfile(
      id: id,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      city: map['city'],
      interests: List<String>.from(map['interests'] ?? []),
      stats: Map<String, int>.from(map['stats'] ?? {}),
      theme: map['theme'] ?? 'roseGold',
      language: map['language'] ?? 'en',
      isPremium: map['isPremium'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'city': city,
      'interests': interests,
      'stats': stats,
      'theme': theme,
      'language': language,
      'isPremium': isPremium,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserProfile copyWith({
    String? displayName,
    String? photoUrl,
    String? city,
    List<String>? interests,
    Map<String, int>? stats,
    String? theme,
    String? language,
    bool? isPremium,
  }) {
    return UserProfile(
      id: id,
      email: email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      city: city ?? this.city,
      interests: interests ?? this.interests,
      stats: stats ?? this.stats,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt,
    );
  }
}
