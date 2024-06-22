import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/fleet_page_state.dart'; // Importe seu estado aqui
import 'package:ss_auto/view/widgets/card_fleet_new_widget.dart';
import 'package:ss_auto/view/widgets/card_fleet_widget.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/floating_action_button_widget.dart';

class FleetPage extends StatelessWidget {
  const FleetPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => FleetPageState(),
        child: Consumer<FleetPageState>(
          builder: (_, state, __) {
            return ListView.builder(
              itemCount: state.listVehicles.length,
              itemBuilder: (context, index) {
                return FutureBuilder<String>(
                  future: state.getPathImagesCars(
                      state.listVehicles[index].licensePlate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erro: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text('Sem dados');
                    } else {
                      return CarCard(
                        brand: state.listVehicles[index].brand,
                        imagePath: snapshot.data!,
                        year: state.listVehicles[index].year,
                        model: state.listVehicles[index].model,
                        price: state.listVehicles[index].dailyCost,
                        status: 'Ativo',
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        color: blue,
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }
}
