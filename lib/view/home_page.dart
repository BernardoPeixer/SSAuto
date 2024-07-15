import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states/home_page_state.dart';
import 'widgets/bar_chart_widget.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/pie_chart_widget.dart';

/// CREATION OF STATELESS WIDGET
class HomePage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFE3F2FD),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: state.maxY == 0
                      ? const Center(
                          child: Text(
                          'Nenhuma venda realizada!',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'COMPARATIVO DE VENDAS MENSAIS',
                              style: TextStyle(
                                color: Color(0xFFca122e),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Expanded(
                              child: BarChartWidget(
                                maxY: state.maxY,
                                rawBarGroups:
                                    state.rawBarGroups.reversed.toList(),
                                getTitlesWidget: state.getTitlesWidget,
                              ),
                            ),
                          ],
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFE3F2FD),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: state.finishedCount.toDouble() == 0 &&
                          state.notRemovedCount.toDouble() == 0 &&
                          state.inProgressCount.toDouble() == 0
                      ? const Center(
                          child: Text(
                            'Nenhum aluguel registrado!',
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        )
                      : Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLegendItem('Finalizado', Colors.green),
                                _buildLegendItem('Não retirado', Colors.blue),
                                _buildLegendItem('Em andamento', Colors.yellow),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'STATUS',
                                    style: TextStyle(
                                      color: Color(0xFFca122e),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: PieChartWidget(
                                      sectionOne:
                                          state.finishedCount.toDouble(),
                                      sectionTwo:
                                          state.notRemovedCount.toDouble(),
                                      sectionThree:
                                          state.inProgressCount.toDouble(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFE3F2FD),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.directions_car_outlined,
                              size: 30,
                            ),
                            Text(
                              '${state.totalVehicles}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Text('Carros'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFE3F2FD),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.person_outline,
                              size: 30,
                            ),
                            Text(
                              '${state.totalCustomers}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Text('Clientes')
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFE3F2FD),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.business_outlined,
                              size: 30,
                            ),
                            Text(
                              '${state.totalAgencys}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Text('Agências'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFE3F2FD),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.monetization_on_outlined,
                              size: 30,
                            ),
                            Text(
                              '${state.totalRents}',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Text('Alugueis'),
                          ],
                        ),
                      ),
                    ],
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

Widget _buildLegendItem(String title, Color color) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        color: color,
      ),
      const SizedBox(width: 4),
      Text(title, style: const TextStyle(fontSize: 12)),
    ],
  );
}
