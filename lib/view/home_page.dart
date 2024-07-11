import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/home_page_state.dart';
import 'package:ss_auto/view/widgets/bottom_app_bar_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Consumer<HomePageState>(builder: (_, state, __) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFca122e),
            actions: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          body: Column(
            children: [
              Center(
                child: ElevatedButton(
                  child: Text(
                    'alugueis realizados',
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/rentalListPage');
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: const SizedBox(
            height: 80,
            child: BottomAppBarWidget(),
          ),
        );
      }),
    );
  }
}
