import 'package:flutter/material.dart';

import 'views/homepage/homepage.dart';

void main() {
  runApp(const InvestApp());
}

class InvestApp extends StatelessWidget {
  const InvestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
