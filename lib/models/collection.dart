class Collection {
  final String id;
  final String title;
  final String? description;
  final String? coverImage;
  final String ownerId;
  final List<String> collaborators;
  final List<String> memoryIds;
  final Map<String, String> reactions;
  final List<Comment> comments;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  Collection({
    required this.id,
    required this.title,
    this.description,
    this.coverImage,
    required this.ownerId,
    this.collaborators = const [],
    this.memoryIds = const [],
    this.reactions = const {},
    this.comments = const [],
    this.isPublic = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Collection.fromMap(Map<String, dynamic> map, String id) {
    return Collection(
      id: id,
      title: map['title'] ?? '',
      description: map['description'],
      coverImage: map['coverImage'],
      ownerId: map['ownerId'] ?? '',
      collaborators: List<String>.from(map['collaborators'] ?? []),
      memoryIds: List<String>.from(map['memoryIds'] ?? []),
      reactions: Map<String, String>.from(map['reactions'] ?? {}),
      comments: (map['comments'] as List? ?? [])
          .map((c) => Comment.fromMap(c))
          .toList(),
      isPublic: map['isPublic'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'coverImage': coverImage,
      'ownerId': ownerId,
      'collaborators': collaborators,
      'memoryIds': memoryIds,
      'reactions': reactions,
      'comments': comments.map((c) => c.toMap()).toList(),
      'isPublic': isPublic,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
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
