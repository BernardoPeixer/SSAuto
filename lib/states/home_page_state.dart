import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/controller/rental_controller.dart';
import 'package:ss_auto/model/chart_model.dart';

class HomePageState with ChangeNotifier {
  HomePageState() {
    addBars();
  }

  final rentalController = RentalController();

  final barGroup1 = BarChartGroupData(x: 50);

  List<ChartModel> list = [];

  final items = <BarChartGroupData>[];
  List<BarChartGroupData> rawBarGroups = [];

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blue,
          width: 20,
        ),
      ],
    );
  }

  double maior = 0;

  void addBars() async {
    final lista = await rentalController.teste();

    list = lista;

    for (var i = 0; i < lista.length; i++) {
      if (lista[i].total == null) {
        continue;
      }

      if(lista[i].total! > maior){
        maior = lista[i].total!;
      }

      items.add(makeGroupData(i, lista[i].total!));
    }

    rawBarGroups = items;
    notifyListeners();
  }

  String getTitlesWidget(value, _) {
    final date = list
        .where(
          (element) => element.index == value.toInt(),
        )
        .first;
    return date.month;
  }
}

class BarChartSample2 extends StatelessWidget {
  const BarChartSample2({super.key});

  final Color leftBarColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageState(),
      child: Consumer<HomePageState>(builder: (_, state, __) {
        return BarChart(
          BarChartData(
            maxY: state.maior,
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    return Text(
                      state.getTitlesWidget(value, _),
                    );
                  },
                  reservedSize: 20,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 1,
                  getTitlesWidget: (x, y) => leftTitles(x, y, context),
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: state.rawBarGroups,
            gridData: const FlGridData(show: false),
          ),
        );
      }),
    );
  }

  Widget leftTitles(double value, TitleMeta meta, BuildContext context) {
    final state = Provider.of<HomePageState>(context);
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontSize: 12,
    );

    String text;
    if (value == state.maior / 3) {
      text = '${(state.maior / 3)}';
    } else if (value == state.maior / 2) {
      text = '${state.maior / 2}';
    } else if (value == state.maior) {
      text = '${state.maior}';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
}
