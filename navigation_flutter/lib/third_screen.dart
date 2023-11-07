import 'package:flutter/material.dart';

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
