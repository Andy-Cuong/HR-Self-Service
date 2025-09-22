import 'package:flutter/material.dart';
import 'package:hr_self_service/src/ui/leave/leave_screen.dart';
import 'package:hr_self_service/src/ui/personnel/personnel_list_screen.dart';
import 'package:hr_self_service/src/ui/settings/setting_screen.dart';

class NavigationRoot extends StatefulWidget {
  const NavigationRoot({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationRootState();
}

class _NavigationRootState extends State<NavigationRoot> {
  int _selectedIndex = 0;
  String _title = 'All Personnels';

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    Color drawerBackgroundColor = Colors.transparent;

    switch (_selectedIndex) {
      case 0:
        currentScreen = const PersonnelListScreen();
        _title = 'All Personnels';
      case 1:
        currentScreen = const LeaveScreen();
        _title = 'Request Leave';
      case 2:
        currentScreen = const SettingScreen();
        _title = 'Settings';
      default:
        currentScreen = const PersonnelListScreen();
        _title = 'All Personnels';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: currentScreen,
      drawer: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('Personnels')
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chair_outlined),
                label: Text('Request Leave')
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings')
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
              Navigator.of(context).pop();
            },
            labelType: NavigationRailLabelType.all,
          ),
          Expanded( // Make the Nav Rail take only as much space as needed
            child: GestureDetector(
              child: Container(
                color: drawerBackgroundColor,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          )
        ],
      ),
      onDrawerChanged: (isOpened) => {
        drawerBackgroundColor = isOpened? Colors.black38 : Colors.transparent
      },
    );
  }
}