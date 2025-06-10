enum ActivityType {
  weeklyClass,
  course,
  privateLesson,
}

class Activity {
  final String id;
  final String name;
  final ActivityType type;
  final DateTime dateStart;
  final DateTime dateEnd;
  final int sessionsPerWeek;
  final String hour; // Format: hh:mm
  final int maxStudents;

  const Activity({
    required this.id,
    required this.name,
    required this.type,
    required this.dateStart,
    required this.dateEnd,
    required this.sessionsPerWeek,
    required this.hour,
    required this.maxStudents,
  });

  // Factory constructor for creating an Activity from JSON
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      name: json['name'] as String,
      type: ActivityType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      dateStart: DateTime.parse(json['date_start'] as String),
      dateEnd: DateTime.parse(json['date_end'] as String),
      sessionsPerWeek: json['sessions_per_week'] as int,
      hour: json['hour'] as String,
      maxStudents: json['max_students'] as int,
    );
  }

  // Convert Activity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last,
      'date_start': dateStart.toIso8601String(),
      'date_end': dateEnd.toIso8601String(),
      'sessions_per_week': sessionsPerWeek,
      'hour': hour,
      'max_students': maxStudents,
    };
  }

  // Create a copy of the Activity with optional new values
  Activity copyWith({
    String? id,
    String? name,
    ActivityType? type,
    DateTime? dateStart,
    DateTime? dateEnd,
    int? sessionsPerWeek,
    String? hour,
    int? maxStudents,
  }) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
      hour: hour ?? this.hour,
      maxStudents: maxStudents ?? this.maxStudents,
    );
  }

  // Format date start as dd/mm/yyyy
  String get formattedDateStart {
    final day = dateStart.day.toString().padLeft(2, '0');
    final month = dateStart.month.toString().padLeft(2, '0');
    final year = dateStart.year.toString();
    return '$day/$month/$year';
  }

  // Format date end as dd/mm/yyyy
  String get formattedDateEnd {
    final day = dateEnd.day.toString().padLeft(2, '0');
    final month = dateEnd.month.toString().padLeft(2, '0');
    final year = dateEnd.year.toString();
    return '$day/$month/$year';
  }

  // Get display name for activity type
  String get typeDisplayName {
    switch (type) {
      case ActivityType.weeklyClass:
        return 'Weekly Class';
      case ActivityType.course:
        return 'Course';
      case ActivityType.privateLesson:
        return 'Private Lesson';
    }
  }
} 