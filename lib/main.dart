import 'package:flutter/material.dart';
import 'package:ss_auto/view/fleet_page.dart';
import 'package:ss_auto/view/vehicle_registration_page.dart';
import 'view/add_options_page.dart';
import 'view/home_page.dart';
import 'view/manager_registration_page.dart';
import 'view/customer_registration_page.dart';

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
        '/customerRegistrationPage': (context) =>
            const CustomerRegistrationPage(),
        '/addOptionsPage': (context) => const AddOptionsPage(),
        '/vehicleRegistrationPage': (context) =>
            const VehicleRegistrationPage(),
        '/managerRegistrationPage': (context) =>
            const ManagerRegistrationPage(),
        '/fleetPage': (context) => const FleetPage(),
      },
    );
  }
}
