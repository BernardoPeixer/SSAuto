import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/customer_registration_state.dart';
import 'package:ss_auto/states/manager_registration_state.dart';
import 'package:ss_auto/view/widgets/customer_list_widget.dart';
import 'package:ss_auto/view/widgets/manager_list_widget.dart';

import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

class ManagerCustomerPage extends StatelessWidget {
  const ManagerCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color blu = const Color(0xff052b57);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: blu,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            'Cadastros',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
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
                    Text('Clientes'),
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
                    Text('Gerentes'),
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
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButtonWidget(
          color: blue,
        ),
        bottomNavigationBar: const BottomAppBarWidget(),
      ),
    );
  }
}
