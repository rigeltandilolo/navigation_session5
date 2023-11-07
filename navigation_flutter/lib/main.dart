import 'package:flutter/material.dart';
import 'package:navigation_flutter/first_screen.dart';
import 'package:navigation_flutter/fourth_screen.dart';
import 'package:navigation_flutter/second_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Codelab',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyBottomNavigationBar(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/first':
            return MaterialPageRoute(builder: (context) => FirstScreen());
          case '/second':
            return MaterialPageRoute(builder: (context) => SecondScreen());
          case '/third':
            return MaterialPageRoute(builder: (context) => ThirdScreen());
          case '/fourth':
            return MaterialPageRoute(builder: (context) => FourthScreen());
          default:
            return MaterialPageRoute(
                builder: (context) => Scaffold(
                      body: Center(
                        child: Text('Route not found'),
                      ),
                    ));
        }
      },
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    FourthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: _children[_currentIndex],
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            if (index < _children.length) {
              setState(() {
                _currentIndex = index;
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Navigation Error: Invalid destination'),
              ));
            }
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.screen_lock_landscape),
              label: 'Screen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter the number of screens to generate:'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToDynamicScreen(context);
              },
              child: Text('Generate Screens'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDynamicScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int numberOfScreens = 0;
        return AlertDialog(
          title: Text('Enter the Number'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              numberOfScreens = int.tryParse(value) ?? 0;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Generate'),
              onPressed: () {
                Navigator.of(context).pop();
                _generateScreens(context, numberOfScreens);
              },
            ),
          ],
        );
      },
    );
  }

  void _generateScreens(BuildContext context, int numberOfScreens) {
    for (var i = 1; i <= numberOfScreens; i++) {
      try {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Dynamic Screen $i'),
              ),
              body: Center(
                child: Text('This is Dynamic Screen $i'),
              ),
            );
          }),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Navigation Error'),
              content: Text('An error occurred during navigation.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}