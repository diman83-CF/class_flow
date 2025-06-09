import 'package:flutter/material.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import 'package:provider/provider.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';
import '../widgets/dynamic_table.dart';
import '../../data/mock/mock_students.dart';
import '../../domain/entities/student.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  Business? _firstBusiness;
  List<Student> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _loadFirstBusiness();
    _loadStudents();
  }

  Future<void> _loadFirstBusiness() async {
    final business = await BusinessProvider.getFirstBusiness();
    if (mounted) {
      setState(() {
        _firstBusiness = business;
      });
    }
  }

  void _loadStudents() {
    setState(() {
      _filteredStudents = MockStudents.students;
    });
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredStudents = MockStudents.students;
      } else {
        _filteredStudents = MockStudents.students
            .where((student) =>
                student.fullName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Define columns for the dynamic table
    final List<TableColumn<Student>> columns = [
      // Full Name - Text presentation
      TableColumnHelper.fullName<Student>(
        dataExtractor: (student) => student.fullName,
        width: 2,
        dataStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Date of Birth - Chip presentation
      TableColumnHelper.dateOfBirth<Student>(
        dataExtractor: (student) => student.formattedDateOfBirth,
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Level - Progress presentation
      TableColumnHelper.level<Student>(
        dataExtractor: (student) => student.level.toString(),
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: DynamicText<Business?>(
          object: _firstBusiness,
          staticText: 'Students',
          style: const TextStyle(fontSize: 20),
          textExtractor: (business) => business?.name ?? 'Students',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add student
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search students...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterStudents,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _filteredStudents.isEmpty
                        ? const Center(
                            child: Text(
                              'No students found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : DynamicTable<Student>(
                            records: _filteredStudents,
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
                                  content: Text('Student selected!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            SideMenu(
              menuItems: menuProvider.menuItems,
              selectedRoute: menuProvider.currentRoute,
              onNavigate: (route) {
                menuProvider.setCurrentRoute(route);
                Navigator.of(context).pushReplacementNamed(route);
              },
            ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: 1, // Students
              onDestinationSelected: (index) {
                final routes = ['/activities', '/students', '/trainers', '/leads'];
                menuProvider.setCurrentRoute(routes[index]);
                Navigator.of(context).pushReplacementNamed(routes[index]);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.calendar_today),
                  label: 'Activities',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people),
                  label: 'Students',
                ),
                NavigationDestination(
                  icon: Icon(Icons.school),
                  label: 'Trainers',
                ),
                NavigationDestination(
                  icon: Icon(Icons.leaderboard),
                  label: 'Leads',
                ),
              ],
            )
          : null,
    );
  }
} 