import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/widgets/login/login-widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const LoginWidget());
  }
}
