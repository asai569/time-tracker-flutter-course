import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:my_time_tracker_flutter_course/common_widgets/platform_alert_dialog.dart';
import 'package:my_time_tracker_flutter_course/services/auth.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestStringOut = PlatformAlertDialog(
            title: 'Logout',
            content: 'are you sure that you want to logout',
            cancelActionText: 'Cancel',
            defauktActionText: 'Logout')
        .show(context);
    // ignore: unrelated_type_equality_checks
    if (didRequestStringOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }
}
