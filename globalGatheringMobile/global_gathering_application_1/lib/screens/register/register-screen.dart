// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:global_gathering_application_1/widgets/register/register-widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: RegisterWidget());
  }
}
