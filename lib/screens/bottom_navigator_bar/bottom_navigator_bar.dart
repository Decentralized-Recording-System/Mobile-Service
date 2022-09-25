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
    const Register(),
    const Login(),
    const VerifyEmail(),
    const Dashboard(),
    const Telemetics(),
    const History(),
    const Setting(),
    const Books(),
  ];
  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.app_registration_rounded,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Register',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.login,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Login',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.verified,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Verify Email',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.car_rental,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Telemetics',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.history,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Setting',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.car_crash,
        color: Color.fromARGB(255, 39, 179, 111),
        size: 36.0,
      ),
      label: 'Car',
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
        selectedItemColor: Color.fromARGB(255, 39, 179, 111),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
