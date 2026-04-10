import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
    // return MaterialApp(home: TestPage());
  }
}

// class TestPage extends StatelessWidget {
//   const TestPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Dismissible(
//         background: Container(color: Colors.red),
//         key: Key('test'),
//         child: Opacity(opacity: 0.2, child: ListTile(title: Text('data'))),
//       ),
//     );
//   }
// }
