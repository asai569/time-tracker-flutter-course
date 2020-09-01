import 'package:flutter/material.dart';
import 'package:my_time_tracker_flutter_course/app/sign_in/home/jobs_page.dart';
import 'package:my_time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:my_time_tracker_flutter_course/services/auth.dart';
import 'package:my_time_tracker_flutter_course/services/database.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);

    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return SignInPage.create(context);
            }
            return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: JobsPage(),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
