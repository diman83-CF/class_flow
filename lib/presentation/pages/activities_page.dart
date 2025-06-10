import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';
import '../widgets/dynamic_table.dart';
import '../widgets/language_selector.dart';
import '../../data/mock/mock_activities.dart';
import '../../domain/entities/activity.dart';
import '../../core/localization/localization_provider.dart';

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
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    // Define columns for the dynamic table
    final List<TableColumn<Activity>> columns = [
      // Name - Text presentation
      TableColumn<Activity>(
        header: localizationProvider.translate('activities.columns.activity_name'),
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
        header: localizationProvider.translate('activities.columns.type'),
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
        header: localizationProvider.translate('activities.columns.start_date'),
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
        header: localizationProvider.translate('activities.columns.end_date'),
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
        header: localizationProvider.translate('activities.columns.sessions_per_week'),
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
        header: localizationProvider.translate('activities.columns.time'),
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
        header: localizationProvider.translate('activities.columns.max_students'),
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
          staticText: localizationProvider.translate('activities.title'),
          style: const TextStyle(fontSize: 20),
          textExtractor: (business) => business?.name ?? localizationProvider.translate('activities.title'),
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
                                hintText: localizationProvider.translate('activities.search_placeholder'),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: _filterActivities,
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
                                child: Text(localizationProvider.translate('activities.filter.all')),
                              ),
                              PopupMenuItem(
                                value: 'active',
                                child: Text(localizationProvider.translate('activities.filter.active')),
                              ),
                              PopupMenuItem(
                                value: 'completed',
                                child: Text(localizationProvider.translate('activities.filter.completed')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Activities table
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: _filteredActivities.isEmpty
                            ? Center(
                                child: Text(
                                  localizationProvider.translate('activities.no_activities_found'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                  textAlign: localizationProvider.isRTL ? TextAlign.right : TextAlign.left,
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
                                    SnackBar(
                                      content: Text(localizationProvider.translate('activities.activity_selected')),
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
              selectedIndex: 0, // Activities
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