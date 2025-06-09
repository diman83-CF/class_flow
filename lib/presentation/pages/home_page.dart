import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home'),
      ),
      body: Row(
        children: [
          Expanded(
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    size: 64,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome to Training Management',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Select a section from the menu to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
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
              selectedIndex: 0, // Home
              onDestinationSelected: (index) {
                final routes = ['/home', '/activities', '/students', '/trainers', '/leads'];
                menuProvider.setCurrentRoute(routes[index]);
                Navigator.of(context).pushReplacementNamed(routes[index]);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
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