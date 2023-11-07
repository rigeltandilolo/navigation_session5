import 'package:flutter/material.dart';
import 'package:navigation_flutter/first_screen.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) => FirstScreen()));
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
