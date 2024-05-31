import 'package:flutter/material.dart';
import 'view/homePage.dart';
import 'view/managerRegistration.dart';
import 'view/customerRegistration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/homePage',
        routes: {
          '/homePage': (context) => const HomePage(),
          '/managerRegistration': (context) => const ManagerRegistration(),
          '/customerRegistration': (context) => const CustomerRegistration(),
    },
    );
  }
}
