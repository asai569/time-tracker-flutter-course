import 'package:flutter/material.dart';
import 'package:my_time_tracker_flutter_course/common_widgets/form_submit_button.dart';
import 'package:my_time_tracker_flutter_course/survices/auth.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget {
  EmailSignInForm({@required this.auth});
  final AuthBase auth;
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toggleFormType() {
    setState(() {
      // ignore: unrelated_type_equality_checks
      _formType = (_formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn);
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in '
        : 'create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'need an account? register '
        : 'have an account? sign in';
    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'email',
          hintText: 'test@test.com',
        ),
      ),
      TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
        ),
      ),
      FormSubmitButton(
          text: primaryText,
          onPressed: () {
            _submit();
          }),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text('forget password'),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
