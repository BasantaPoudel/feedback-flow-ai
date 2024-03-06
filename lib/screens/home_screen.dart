import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Home(),
    FeedBack(),
    Search(),
    Stats(),
    Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Activities(),
    );
  }
}

class FeedBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('FeedBack'));
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search'));
  }
}

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Stats'));
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile'));
  }
}
