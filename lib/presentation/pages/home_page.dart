import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';
import '../widgets/language_selector.dart';
import '../../core/localization/localization_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    // Create the side menu widget
    final sideMenu = !isMobile ? SideMenu(
      menuItems: menuProvider.menuItems,
      selectedRoute: menuProvider.currentRoute,
      onNavigate: (route) {
        menuProvider.setCurrentRoute(route);
        Navigator.of(context).pushReplacementNamed(route);
      },
    ) : null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizationProvider.appTitle),
        actions: const [
          LanguageSelector(),
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
                  left: localizationProvider.isLTR && sideMenu != null ? 250 : 0,
                  right: localizationProvider.isRTL && sideMenu != null ? 250 : 0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.home,
                        size: 64,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        localizationProvider.welcome,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: localizationProvider.isRTL ? TextAlign.right : TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizationProvider.selectSection,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: localizationProvider.isRTL ? TextAlign.right : TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Side menu for LTR (left side)
            if (localizationProvider.isLTR && sideMenu != null)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: sideMenu,
              ),
            
            // Side menu for RTL (right side)
            if (localizationProvider.isRTL && sideMenu != null)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: sideMenu,
              ),
          ],
        ),
      ),
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: 0, // Home
              onDestinationSelected: (index) {
                final routes = ['/home', '/activities', '/students', '/trainers', '/leads'];
                menuProvider.setCurrentRoute(routes[index]);
                Navigator.of(context).pushReplacementNamed(routes[index]);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home),
                  label: localizationProvider.home,
                ),
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