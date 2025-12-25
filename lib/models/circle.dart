enum CircleType {
  family,
  friends,
  location, // city-based like "Dubai Circle", "Khobar Circle"
  interest, // interest-based like "Cafe Circle", "Recipe Circle"
  custom,
}

class Circle {
  final String id;
  final String name;
  final String? description;
  final String? icon; // emoji or icon name
  final String ownerId;
  final List<String> memberIds;
  final CircleType type;
  final int memoryCount;
  final String? coverImage;
  final DateTime createdAt;
  final DateTime lastActivityAt;
  final bool isMuted;

  Circle({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    required this.ownerId,
    this.memberIds = const [],
    this.type = CircleType.custom,
    this.memoryCount = 0,
    this.coverImage,
    required this.createdAt,
    required this.lastActivityAt,
    this.isMuted = false,
  });

  factory Circle.fromMap(Map<String, dynamic> map, String id) {
    return Circle(
      id: id,
      name: map['name'] ?? '',
      description: map['description'],
      icon: map['icon'],
      ownerId: map['ownerId'] ?? '',
      memberIds: List<String>.from(map['memberIds'] ?? []),
      type: CircleType.values.firstWhere(
        (e) => e.toString() == 'CircleType.${map['type']}',
        orElse: () => CircleType.custom,
      ),
      memoryCount: map['memoryCount'] ?? 0,
      coverImage: map['coverImage'],
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      lastActivityAt: DateTime.parse(map['lastActivityAt'] ?? DateTime.now().toIso8601String()),
      isMuted: map['isMuted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'icon': icon,
      'ownerId': ownerId,
      'memberIds': memberIds,
      'type': type.toString().split('.').last,
      'memoryCount': memoryCount,
      'coverImage': coverImage,
      'createdAt': createdAt.toIso8601String(),
      'lastActivityAt': lastActivityAt.toIso8601String(),
      'isMuted': isMuted,
    };
  }

  Circle copyWith({
    String? name,
    String? description,
    String? icon,
    List<String>? memberIds,
    int? memoryCount,
    String? coverImage,
    DateTime? lastActivityAt,
    bool? isMuted,
  }) {
    return Circle(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      ownerId: ownerId,
      memberIds: memberIds ?? this.memberIds,
      type: type,
      memoryCount: memoryCount ?? this.memoryCount,
      coverImage: coverImage ?? this.coverImage,
      createdAt: createdAt,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}

// Shared memory in a circle
class CircleMemory {
  final String id;
  final String memoryId; // reference to Memory
  final String circleId;
  final String sharedByUserId;
  final String sharedByUserName;
  final String? sharedByUserPhoto;
  final DateTime sharedAt;
  final Map<String, String> reactions; // userId: reactionType
  final List<Comment> comments;
  final int saveCount; // how many saved to their vault

  CircleMemory({
    required this.id,
    required this.memoryId,
    required this.circleId,
    required this.sharedByUserId,
    required this.sharedByUserName,
    this.sharedByUserPhoto,
    required this.sharedAt,
    this.reactions = const {},
    this.comments = const [],
    this.saveCount = 0,
  });

  factory CircleMemory.fromMap(Map<String, dynamic> map, String id) {
    return CircleMemory(
      id: id,
      memoryId: map['memoryId'] ?? '',
      circleId: map['circleId'] ?? '',
      sharedByUserId: map['sharedByUserId'] ?? '',
      sharedByUserName: map['sharedByUserName'] ?? 'Anonymous',
      sharedByUserPhoto: map['sharedByUserPhoto'],
      sharedAt: DateTime.parse(map['sharedAt'] ?? DateTime.now().toIso8601String()),
      reactions: Map<String, String>.from(map['reactions'] ?? {}),
      comments: (map['comments'] as List? ?? [])
          .map((c) => Comment.fromMap(c))
          .toList(),
      saveCount: map['saveCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'memoryId': memoryId,
      'circleId': circleId,
      'sharedByUserId': sharedByUserId,
      'sharedByUserName': sharedByUserName,
      'sharedByUserPhoto': sharedByUserPhoto,
      'sharedAt': sharedAt.toIso8601String(),
      'reactions': reactions,
      'comments': comments.map((c) => c.toMap()).toList(),
      'saveCount': saveCount,
    };
  }
}

class Comment {
  final String userId;
  final String userName;
  final String? userPhoto;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.userId,
    required this.userName,
    this.userPhoto,
    required this.text,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? 'Anonymous',
      userPhoto: map['userPhoto'],
      text: map['text'] ?? '',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

// Reaction types
enum ReactionType {
  yum,        // 😋 For food/recipes
  mustTry,    // ⭐ For places/experiences
  kidApproved, // 👶 For kid-friendly spots
  worthIt,    // 💰 For deals/value
  tooCrowded, // 👥 For busy places
  love,       // ❤️ General love
}

extension ReactionTypeExtension on ReactionType {
  String get emoji {
    switch (this) {
      case ReactionType.yum:
        return '😋';
      case ReactionType.mustTry:
        return '⭐';
      case ReactionType.kidApproved:
        return '👶';
      case ReactionType.worthIt:
        return '💰';
      case ReactionType.tooCrowded:
        return '👥';
      case ReactionType.love:
        return '❤️';
    }
  }

  String get label {
    switch (this) {
      case ReactionType.yum:
        return 'Yum';
      case ReactionType.mustTry:
        return 'Must-try';
      case ReactionType.kidApproved:
        return 'Kid-approved';
      case ReactionType.worthIt:
        return 'Worth it';
      case ReactionType.tooCrowded:
        return 'Too crowded';
      case ReactionType.love:
        return 'Love';
    }
  }
}
