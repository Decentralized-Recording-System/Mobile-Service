import 'package:flutter/material.dart';
import '../index.dart';

class Launcher extends StatefulWidget {
  static const String id = 'Launcher';

  const Launcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;
  final List<Widget> _pageWidget = <Widget>[
    const Dashboard(),
    const Telemetics(),
    const History(),
    const Setting(),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Colors.blue,
        size: 36.0,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.car_rental,
        color: Colors.blue,
        size: 36.0,
      ),
      label: 'Telemetics',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.history,
        color: Colors.blue,
        size: 36.0,
      ),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
        color: Colors.blue,
        size: 36.0,
      ),
      label: 'Setting',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
