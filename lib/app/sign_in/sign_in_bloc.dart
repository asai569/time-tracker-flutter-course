import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:my_time_tracker_flutter_course/services/auth.dart';

class SignInBloc {
  SignInBloc({
    @required this.auth,
    @required this.isLoading,
  });
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() SignInMethod) async {
    try {
      isLoading.value = true;
      return await SignInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}
