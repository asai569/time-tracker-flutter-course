import 'package:flutter/material.dart';
import 'package:my_time_tracker_flutter_course/survices/auth.dart';

import 'email_sign_in_form.dart';

class EmailSignPage extends StatelessWidget {
  EmailSignPage({@required this.auth});

  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign in '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: _buildCountent()),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  _buildCountent() {
    return Container(
      child: EmailSignInForm(
        auth: auth,
      ),
    );
  }
}
