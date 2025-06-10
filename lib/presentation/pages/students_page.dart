import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';
import '../widgets/dynamic_table.dart';
import '../widgets/language_selector.dart';
import '../../data/mock/mock_students.dart';
import '../../domain/entities/student.dart';
import '../../core/localization/localization_provider.dart';

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
    final localizationProvider = Provider.of<LocalizationProvider>(context);
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
          staticText: localizationProvider.translate('students.title'),
          style: const TextStyle(fontSize: 20),
          textExtractor: (business) => business?.name ?? localizationProvider.translate('students.title'),
        ),
        actions: [
          const LanguageSelector(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: localizationProvider.textDirection,
        child: Stack(
          children: [
            // Main content
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: !isMobile && localizationProvider.isLTR ? 250 : 0,
                  right: !isMobile && localizationProvider.isRTL ? 250 : 0,
                ),
                child: Column(
                  children: [
                    // Search and filter bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: localizationProvider.translate('students.search_placeholder'),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: _filterStudents,
                            ),
                          ),
                          const SizedBox(width: 16),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.filter_list),
                            onSelected: (value) {
                              // TODO: Implement filtering
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'all',
                                child: Text(localizationProvider.translate('students.filter.all')),
                              ),
                              PopupMenuItem(
                                value: 'active',
                                child: Text(localizationProvider.translate('students.filter.active')),
                              ),
                              PopupMenuItem(
                                value: 'inactive',
                                child: Text(localizationProvider.translate('students.filter.inactive')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Students table
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _filteredStudents.isEmpty
                            ? Center(
                                child: Text(
                                  localizationProvider.translate('students.no_students_found'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                  textAlign: localizationProvider.isRTL ? TextAlign.right : TextAlign.left,
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
                                    SnackBar(
                                      content: Text(localizationProvider.translate('students.student_selected')),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Side menu for LTR (left side)
            if (!isMobile && localizationProvider.isLTR)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: SideMenu(
                  menuItems: menuProvider.menuItems,
                  selectedRoute: menuProvider.currentRoute,
                  onNavigate: (route) {
                    menuProvider.setCurrentRoute(route);
                    Navigator.of(context).pushReplacementNamed(route);
                  },
                ),
              ),
            
            // Side menu for RTL (right side)
            if (!isMobile && localizationProvider.isRTL)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SideMenu(
                  menuItems: menuProvider.menuItems,
                  selectedRoute: menuProvider.currentRoute,
                  onNavigate: (route) {
                    menuProvider.setCurrentRoute(route);
                    Navigator.of(context).pushReplacementNamed(route);
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: 1, // Students
              onDestinationSelected: (index) {
                final routes = ['/activities', '/students', '/trainers', '/leads'];
                menuProvider.setCurrentRoute(routes[index]);
                Navigator.of(context).pushReplacementNamed(routes[index]);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.calendar_today),
                  label: localizationProvider.activities,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.people),
                  label: localizationProvider.students,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.school),
                  label: localizationProvider.trainers,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.leaderboard),
                  label: localizationProvider.leads,
                ),
              ],
            )
          : null,
    );
  }
} 