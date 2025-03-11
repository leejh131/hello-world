# Flutter Hello World 앱

아래는 Flutter로 만든 "Hello, World!" 앱의 코드입니다.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World',
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello, World!')),
        body: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
