import 'package:flutter/material.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import 'package:provider/provider.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';
import '../widgets/dynamic_table.dart';
import '../../data/mock/mock_activities.dart';
import '../../domain/entities/activity.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  Business? _firstBusiness;
  List<Activity> _filteredActivities = [];

  @override
  void initState() {
    super.initState();
    _loadFirstBusiness();
    _loadActivities();
  }

  Future<void> _loadFirstBusiness() async {
    final business = await BusinessProvider.getFirstBusiness();
    if (mounted) {
      setState(() {
        _firstBusiness = business;
      });
    }
  }

  void _loadActivities() {
    setState(() {
      _filteredActivities = MockActivities.activities;
    });
  }

  void _filterActivities(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredActivities = MockActivities.activities;
      } else {
        _filteredActivities = MockActivities.activities
            .where((activity) =>
                activity.name.toLowerCase().contains(query.toLowerCase()) ||
                activity.typeDisplayName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Define columns for the dynamic table
    final List<TableColumn<Activity>> columns = [
      // Name - Text presentation
      TableColumn<Activity>(
        header: 'Activity Name',
        dataExtractor: (activity) => activity.name,
        presentationType: PresentationType.text,
        width: 2,
        dataStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      
      // Type - Badge presentation
      TableColumn<Activity>(
        header: 'Type',
        dataExtractor: (activity) => activity.typeDisplayName,
        presentationType: PresentationType.badge,
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.blue.shade100,
      ),
      
      // Date Start - Chip presentation
      TableColumn<Activity>(
        header: 'Start Date',
        dataExtractor: (activity) => activity.formattedDateStart,
        presentationType: PresentationType.chip,
        width: 1.2,
        dataStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.green.shade100,
      ),
      
      // Date End - Chip presentation
      TableColumn<Activity>(
        header: 'End Date',
        dataExtractor: (activity) => activity.formattedDateEnd,
        presentationType: PresentationType.chip,
        width: 1.2,
        dataStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.orange.shade100,
      ),
      
      // Sessions per Week - Card presentation
      TableColumn<Activity>(
        header: 'Sessions/Week',
        dataExtractor: (activity) => activity.sessionsPerWeek.toString(),
        presentationType: PresentationType.card,
        width: 1,
        dataStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.purple.shade50,
      ),
      
      // Hour - Text presentation
      TableColumn<Activity>(
        header: 'Time',
        dataExtractor: (activity) => activity.hour,
        presentationType: PresentationType.text,
        width: 1,
        dataStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      // Max Students - Progress presentation
      TableColumn<Activity>(
        header: 'Max Students',
        dataExtractor: (activity) => activity.maxStudents.toString(),
        presentationType: PresentationType.progress,
        width: 1.5,
        dataStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.teal,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: DynamicText<Business?>(
          object: _firstBusiness,
          staticText: 'Activities',
          style: const TextStyle(fontSize: 20),
          textExtractor: (business) => business?.name ?? 'Activities',
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: () {
          //     // TODO: Implement add activity
          //   },
          // ),
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
                      hintText: 'Search activities...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterActivities,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _filteredActivities.isEmpty
                        ? const Center(
                            child: Text(
                              'No activities found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : DynamicTable<Activity>(
                            records: _filteredActivities,
                            columns: columns,
                            showHeader: true,
                            bordered: true,
                            headerBackgroundColor: Colors.blue.shade50,
                            rowBackgroundColor: Colors.white,
                            alternateRowBackgroundColor: Colors.grey.shade50,
                            rowHeight: 80,
                            padding: const EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(8),
                            onRowTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Activity selected!'),
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
              selectedIndex: 0, // Activities
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