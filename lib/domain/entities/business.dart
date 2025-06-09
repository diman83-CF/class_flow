class Business {
  final String id;
  final String name;
  final DateTime dateCreated;

  const Business({
    required this.id,
    required this.name,
    required this.dateCreated,
  });

  // Factory constructor for creating a Business from JSON
  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] as String,
      name: json['name'] as String,
      dateCreated: DateTime.parse(json['date_created'] as String),
    );
  }

  // Convert Business to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date_created': dateCreated.toIso8601String(),
    };
  }

  // Create a copy of the Business with optional new values
  Business copyWith({
    String? id,
    String? name,
    DateTime? dateCreated,
  }) {
    return Business(
      id: id ?? this.id,
      name: name ?? this.name,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }
} 