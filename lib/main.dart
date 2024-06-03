import 'package:flutter/material.dart';
import 'package:ss_auto/view/vehicleRegistration.dart';
import 'view/addOptionsScreen.dart';
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
          '/addOptionsScreen': (context) => const AddOptionsScreen(),
          '/vehicleRegistration': (context) => const VehicleRegistration(),
          '/managerRegistration': (context) => const ManagerRegistration(),
    },
    );
  }
}
