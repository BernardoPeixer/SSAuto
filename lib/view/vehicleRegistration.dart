import 'package:flutter/material.dart';
import 'package:ss_auto/model/vehicleRegistrationState.dart';
import 'package:ss_auto/view/widgets/optionYesNo.dart';
import 'package:ss_auto/view/widgets/textFormFieldVehicles.dart';
import 'package:provider/provider.dart';

class VehicleRegistration extends StatelessWidget {
  const VehicleRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color blu = const Color(0xff052b57);
    Color orange = const Color(0xffD3393A);
    return ChangeNotifierProvider(
      create: (context) => VehicleRegistrationState(),
      child: Consumer<VehicleRegistrationState>(builder: (context, state, _) {
        return Scaffold(
          backgroundColor: blue,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: blu,
            centerTitle: true,
            title: const Text(
              'Cadastro de Veículo',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldVehicles(title: 'Marca:', color: orange),
                  TextFormFieldVehicles(title: 'Modelo:', color: orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldVehicles(title: 'Placa:', color: orange),
                  TextFormFieldVehicles(title: 'Ano:', color: orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldVehicles(title: 'Categoria:', color: orange),
                  TextFormFieldVehicles(
                      title: 'Custo da Diária:', color: orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormFieldVehicles(
                      title: 'Quilometragem Atual:', color: orange),
                  TextFormFieldVehicles(title: 'Cor:', color: orange),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OptionYesNo(
                    title: 'Ar Condicionado:',
                  ),
                  OptionYesNo(
                    title: 'Sensor:',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Fotos do Veículo:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const Text(
                        '(Selecione até 5 fotos)',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10 ,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.3,
                          height: MediaQuery.of(context).size.height / 5.5,
                          decoration: BoxDecoration(
                            color: orange,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
