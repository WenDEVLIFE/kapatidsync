import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginUi extends StatelessWidget {
  const LoginUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}