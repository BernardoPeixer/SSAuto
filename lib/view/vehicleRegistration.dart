import 'package:flutter/material.dart';
import 'package:ss_auto/states/vehicleRegistrationState.dart';
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
          resizeToAvoidBottomInset: false,
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
          body: Form(
            key: state.keyFormVehicle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormFieldVehicles(
                      title: 'Marca:',
                      color: orange,
                      controller: state.controllerBrand,
                      validator: (value) =>
                          state.name(state.controllerBrand.text),
                    ),
                    TextFormFieldVehicles(
                      title: 'Modelo:',
                      color: orange,
                      controller: state.controllerModel,
                      validator: (value) =>
                          state.name(state.controllerModel.text),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormFieldVehicles(
                      title: 'Placa:',
                      color: orange,
                      controller: state.controllerLicensePlate,
                      validator: (value) =>
                          state.name(state.controllerLicensePlate.text),
                    ),
                    TextFormFieldVehicles(
                      title: 'Ano:',
                      color: orange,
                      controller: state.controllerYear,
                      validator: (value) =>
                          state.name(state.controllerYear.text),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormFieldVehicles(
                      title: 'Categoria:',
                      color: orange,
                      controller: state.controllerCategory,
                      validator: (value) =>
                          state.name(state.controllerCategory.text),
                    ),
                    TextFormFieldVehicles(
                      title: 'Custo da Diária:',
                      color: orange,
                      controller: state.controllerDailyCost,
                      validator: (value) =>
                          state.name(state.controllerDailyCost.text),
                      inputType: TextInputType.number,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormFieldVehicles(
                      title: 'Quilometragem Atual:',
                      color: orange,
                      controller: state.controllerMileage,
                      validator: (value) =>
                          state.name(state.controllerMileage.text),
                      inputType: TextInputType.number,
                    ),
                    TextFormFieldVehicles(
                      title: 'Cor:',
                      color: orange,
                      controller: state.controllerColor,
                      validator: (value) =>
                          state.name(state.controllerColor.text),
                      inputType: TextInputType.text,
                    ),
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
                          height: 10,
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
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(orange),
                            ),
                            onPressed: () {
                              if(state.keyFormVehicle.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
