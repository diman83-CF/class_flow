import 'package:flutter/material.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import 'package:provider/provider.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage> {
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
          staticText: 'Trainers',
          style: const TextStyle(fontSize: 20),
          textExtractor: (business) => business?.name ?? 'Trainers',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add trainer
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
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search trainers...',
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
                      const SizedBox(width: 8),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.sort),
                        onSelected: (value) {
                          // TODO: Implement sorting
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'name',
                            child: Text('Sort by Name'),
                          ),
                          const PopupMenuItem(
                            value: 'experience',
                            child: Text('Sort by Experience'),
                          ),
                          const PopupMenuItem(
                            value: 'rating',
                            child: Text('Sort by Rating'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 0, // TODO: Replace with actual trainers
                    itemBuilder: (context, index) {
                      return const Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.school),
                          ),
                          title: Text('Trainer Name'),
                          subtitle: Text('Specialization • Experience'),
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
              selectedIndex: 2, // Trainers
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