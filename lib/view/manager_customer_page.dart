import 'package:flutter/material.dart';

import 'widgets/agency_list_widget.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/customer_list_widget.dart';
import 'widgets/manager_list_widget.dart';

/// CREATION OF STATELESS WIDGET
class ManagerCustomerPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const ManagerCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFca122e),
          actions: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/logo/ss_horizontal_logo.png',
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Clientes',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.supervisor_account),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gerentes',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    Icon(Icons.business_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Agências',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CustomerListWidget(),
            ManagerListWidget(),
            AgencyListWidget(),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFFca122e),
          height: 80,
          child: const BottomAppBarWidget(),
        ),
      ),
    );
  }
}
