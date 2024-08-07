import 'package:flutter/material.dart';

import '../add_options_page.dart';
import '../fleet_page.dart';
import '../home_page.dart';
import '../manager_customer_page.dart';
import '../rental_filters_page.dart';

/// CREATION OF STATELESS WIDGET
class BottomAppBarWidget extends StatelessWidget {
  /// FUNCTION TO RENTAL FILTERS
  final void Function()? function;

  /// STATELESS WIDGET BUILDER
  const BottomAppBarWidget({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFFca122e),
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x26ca122e),
              offset: Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
              thickness: 2,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const RentalFiltersPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
                function;
              },
              icon: const Icon(
                Icons.monetization_on_outlined,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
              thickness: 2,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const FleetPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.directions_car_outlined,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            const VerticalDivider(
              indent: 10,
              endIndent: 10,
              thickness: 2,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ManagerCustomerPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.person_outline_outlined,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            IconButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AddOptionsPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Color(0xFFca122e),
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
