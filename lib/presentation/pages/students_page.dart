import 'package:flutter/material.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import 'package:provider/provider.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  Business? _firstBusiness;

  @override
  void initState() {
    super.initState();
    _loadFirstBusiness();
  }

  Future<void> _loadFirstBusiness() async {
    final business = await BusinessProvider.getFirstBusiness();
    if (mounted) {
      setState(() {
        _firstBusiness = business;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
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
                    onChanged: (value) {
                      // TODO: Implement search functionality
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 0, // TODO: Replace with actual students
                    itemBuilder: (context, index) {
                      return const Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text('Student Name'),
                          subtitle: Text('Course • Status'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
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