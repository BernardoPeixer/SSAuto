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
                    mainAxisAlignment: MainAxisAlignment.start,
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
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text(
                  'Suas Atividades',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                            value: 90,
                            title: 'Finalizados',
                            showTitle: true,
                            radius: 70,
                            color: Colors.green),
                        PieChartSectionData(
                            value: 300,
                            title: 'Em andamento',
                            showTitle: true,
                            radius: 70,
                            color: Colors.yellow),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 500,
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: LineChart(
                    LineChartData(
                      backgroundColor: Colors.red,
                      lineBarsData: [
                        LineChartBarData(
                          spots: state.spots,
                          color: Colors.black,
                          barWidth: 4,
                          isCurved: false,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
