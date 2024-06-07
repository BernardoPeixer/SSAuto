import 'package:flutter/material.dart';
import 'package:ss_auto/view/vehicle_registration.dart';
import 'view/add_options_screen.dart';
import 'view/home_page.dart';
import 'view/manager_registration.dart';
import 'view/customer_registration.dart';

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
