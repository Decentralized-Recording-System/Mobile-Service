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
  late Color selectedColor = Theme.of(context).primaryColor;

  late final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 36.0,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.car_rental,
        size: 36.0,
      ),
      label: 'Telemetics',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.history,
        size: 36.0,
      ),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
