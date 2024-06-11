import 'package:flutter/material.dart';

import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

class ManagerCustomerPage extends StatelessWidget {
  const ManagerCustomerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color blu = const Color(0xff052b57);
    Color orange = const Color(0xffD3393A);
    return DefaultTabController(
      length: 2, // número de tabs
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
                    const SizedBox(
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
                    const SizedBox(
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
            Text('Clientes'),
            Text('Gerentes'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButtonWidget(
          color: blue,
        ),
        bottomNavigationBar: const BottomAppBarWidget(),
      ),
    );
  }
}
