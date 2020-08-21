import 'package:flutter/material.dart';
import 'package:my_time_tracker_flutter_course/survices/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth});
  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home Page'),
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: (Text('Logout')),
          )
        ],
      ),
    );
  }
}
