import 'package:flutter/material.dart';
import '../../domain/entities/person.dart';
import 'dynamic_table.dart';

/// Example widget demonstrating how to use the DynamicTable
class DynamicTableExample extends StatelessWidget {
  const DynamicTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<Person> people = [
      Person(
        id: '1',
        fullName: 'John Doe',
        dateOfBirth: DateTime(1990, 5, 15),
        level: 8,
      ),
      Person(
        id: '2',
        fullName: 'Jane Smith',
        dateOfBirth: DateTime(1985, 12, 3),
        level: 10,
      ),
      Person(
        id: '3',
        fullName: 'Bob Johnson',
        dateOfBirth: DateTime(1995, 8, 22),
        level: 5,
      ),
      Person(
        id: '4',
        fullName: 'Alice Brown',
        dateOfBirth: DateTime(1988, 3, 10),
        level: 7,
      ),
      Person(
        id: '5',
        fullName: 'Charlie Wilson',
        dateOfBirth: DateTime(1992, 11, 7),
        level: 3,
      ),
    ];

    // Define columns with different presentation types
    final List<TableColumn<Person>> columns = [
      // Full Name - Text presentation
      TableColumnHelper.fullName<Person>(
        dataExtractor: (person) => person.fullName,
        width: 2,
        dataStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Date of Birth - Chip presentation
      TableColumnHelper.dateOfBirth<Person>(
        dataExtractor: (person) => person.formattedDateOfBirth,
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Level - Progress presentation
      TableColumnHelper.level<Person>(
        dataExtractor: (person) => person.level.toString(),
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Table Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Person Records',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: DynamicTable<Person>(
                records: people,
                columns: columns,
                showHeader: true,
                bordered: true,
                headerBackgroundColor: Colors.blue.shade50,
                rowBackgroundColor: Colors.white,
                alternateRowBackgroundColor: Colors.grey.shade50,
                rowHeight: 70,
                padding: const EdgeInsets.all(12),
                borderRadius: BorderRadius.circular(8),
                onRowTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Row tapped!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Presentation Types:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLegendItem('Full Name', 'Text presentation', Colors.blue),
        _buildLegendItem('Date of Birth', 'Chip presentation', Colors.green),
        _buildLegendItem('Level', 'Progress bar (1-10)', Colors.orange),
      ],
    );
  }

  Widget _buildLegendItem(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Alternative example with different presentation types
class DynamicTableAlternativeExample extends StatelessWidget {
  const DynamicTableAlternativeExample({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Person> people = [
      Person(
        id: '1',
        fullName: 'John Doe',
        dateOfBirth: DateTime(1990, 5, 15),
        level: 8,
      ),
      Person(
        id: '2',
        fullName: 'Jane Smith',
        dateOfBirth: DateTime(1985, 12, 3),
        level: 10,
      ),
    ];

    // Alternative column configuration with different presentation types
    final List<TableColumn<Person>> columns = [
      // Full Name - Card presentation
      TableColumn<Person>(
        header: 'Full Name',
        dataExtractor: (person) => person.fullName,
        presentationType: PresentationType.card,
        width: 2,
        backgroundColor: Colors.purple.shade50,
      ),
      
      // Date of Birth - Badge presentation
      TableColumn<Person>(
        header: 'Date of Birth',
        dataExtractor: (person) => person.formattedDateOfBirth,
        presentationType: PresentationType.badge,
        width: 1.5,
        backgroundColor: Colors.teal.shade100,
        borderColor: Colors.teal,
      ),
      
      // Level - Text presentation with custom styling
      TableColumn<Person>(
        header: 'Level',
        dataExtractor: (person) => 'Level ${person.level}',
        presentationType: PresentationType.text,
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alternative Table Example'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DynamicTable<Person>(
          records: people,
          columns: columns,
          showHeader: true,
          bordered: true,
          headerBackgroundColor: Colors.purple.shade50,
          rowBackgroundColor: Colors.white,
          alternateRowBackgroundColor: Colors.purple.shade25,
          rowHeight: 80,
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
} 