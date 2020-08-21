import 'package:flutter/material.dart';
import 'package:my_time_tracker_flutter_course/app/home_page.dart';
import 'package:my_time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:my_time_tracker_flutter_course/survices/auth.dart';

class LandingPage extends StatelessWidget {
  LandingPage({@required this.auth});
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data;

          if (user == null) {
            return SignInPage(
              auth: auth,
            );
          }

          return HomePage(
            auth: auth,
          );
        } else {
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
