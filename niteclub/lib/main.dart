import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

import 'ui/Home.dart';
import 'ui/Map.dart';
import 'injector.dart';

void main() {
  setipInyection();
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MenuHome(),
    );
  }
}

class MenuHome extends StatefulWidget {
  MenuHome({Key key}) : super(key: key);
  @override
  _MenuHome createState() => _MenuHome();
}

class _MenuHome extends State<MenuHome> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle barStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    MapSample(),
    Text(
      'Notifications',
      style: optionStyle,
    ),
    Text(
      'Profiel',
      style: optionStyle,
    ),
  ];

  MotionTabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new MotionTabController(initialIndex:1,length:4,vsync:this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        labels: ["Home", "Map", "Notification", "Profile"],
        icons: [
          Icons.home,
          Icons.map,
          Icons.notifications_none,
          Icons.person
        ],
        tabIconColor: Colors.black,
        tabSelectedColor: Colors.black,
        initialSelectedTab: "Home",
        textStyle: barStyle,
        onTabItemSelected: (int value) {
          setState(() {
            _selectedIndex = value;
            _tabController.index = value;
          });
        },
      )
      /*
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Maps'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            title: Text('Alerts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),*/
    );
  }
}

