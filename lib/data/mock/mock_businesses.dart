import '../../domain/entities/business.dart';

class MockBusinesses {
  static final List<Business> businesses = [
    Business(
      id: '1',
      name: 'Tech Innovators Inc.',
      dateCreated: DateTime(2023, 1, 15),
    ),
    Business(
      id: '2',
      name: 'Global Solutions Ltd.',
      dateCreated: DateTime(2023, 3, 22),
    ),
    Business(
      id: '3',
      name: 'Future Dynamics Corp.',
      dateCreated: DateTime(2023, 6, 8),
    ),
    Business(
      id: '4',
      name: 'Smart Systems Co.',
      dateCreated: DateTime(2023, 9, 30),
    ),
  ];
} 