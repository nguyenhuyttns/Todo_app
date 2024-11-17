import 'package:flutter/material.dart';
import 'package:to_do_app/keys/keys.dart'; // Import file chứa logic cho Todo list

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const Keys(),
    );
  }
}
