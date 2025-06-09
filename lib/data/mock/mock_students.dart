import '../../domain/entities/student.dart';

class MockStudents {
  static final List<Student> students = [
    Student(
      id: '1',
      fullName: 'John Smith',
      dateOfBirth: DateTime(2010, 5, 15),
      level: 8,
    ),
    Student(
      id: '2',
      fullName: 'Emma Johnson',
      dateOfBirth: DateTime(2012, 8, 22),
      level: 6,
    ),
    Student(
      id: '3',
      fullName: 'Michael Brown',
      dateOfBirth: DateTime(2009, 3, 10),
      level: 9,
    ),
    Student(
      id: '4',
      fullName: 'Sarah Davis',
      dateOfBirth: DateTime(2011, 12, 5),
      level: 7,
    ),
    Student(
      id: '5',
      fullName: 'David Wilson',
      dateOfBirth: DateTime(2013, 7, 18),
      level: 5,
    ),
    Student(
      id: '6',
      fullName: 'Lisa Anderson',
      dateOfBirth: DateTime(2008, 11, 30),
      level: 10,
    ),
    Student(
      id: '7',
      fullName: 'Robert Taylor',
      dateOfBirth: DateTime(2012, 4, 12),
      level: 6,
    ),
    Student(
      id: '8',
      fullName: 'Jennifer Martinez',
      dateOfBirth: DateTime(2010, 9, 25),
      level: 8,
    ),
    Student(
      id: '9',
      fullName: 'Christopher Garcia',
      dateOfBirth: DateTime(2011, 2, 8),
      level: 7,
    ),
    Student(
      id: '10',
      fullName: 'Amanda Rodriguez',
      dateOfBirth: DateTime(2013, 1, 20),
      level: 5,
    ),
  ];
} 