class Student {
  final String id;
  final String fullName;
  final DateTime dateOfBirth;
  final int level; // 1 to 10

  const Student({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.level,
  });

  // Factory constructor for creating a Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      level: json['level'] as int,
    );
  }

  // Convert Student to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'level': level,
    };
  }

  // Create a copy of the Student with optional new values
  Student copyWith({
    String? id,
    String? fullName,
    DateTime? dateOfBirth,
    int? level,
  }) {
    return Student(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      level: level ?? this.level,
    );
  }

  // Format date of birth as dd/mm/yy
  String get formattedDateOfBirth {
    final day = dateOfBirth.day.toString().padLeft(2, '0');
    final month = dateOfBirth.month.toString().padLeft(2, '0');
    final year = (dateOfBirth.year % 100).toString().padLeft(2, '0');
    return '$day/$month/$year';
  }
} 