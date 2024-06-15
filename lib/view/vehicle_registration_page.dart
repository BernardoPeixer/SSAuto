import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';
import 'package:ss_auto/view/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class VehicleRegistrationPage extends StatelessWidget {
  const VehicleRegistrationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color orange = const Color(0xffD3393A);

    return ChangeNotifierProvider(
      create: (context) => VehicleRegistrationState(),
      child: Consumer<VehicleRegistrationState>(
        builder: (_, state, __) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: blue,
            appBar: AppBar(
              backgroundColor: blue,
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: state.keyFormVehicle,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        color: orange,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextFormFieldWidget(
                                title: 'Marca:',
                                color: blue,
                                controller: state.controllerBrand,
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldWidget(
                                title: 'Modelo:',
                                color: blue,
                                controller: state.controllerModel,
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldWidget(
                                title: 'Placa:',
                                color: blue,
                                controller: state.controllerLicensePlate,
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldWidget(
                                title: 'Ano:',
                                color: blue,
                                controller: state.controllerYear,
                              ),
                              const SizedBox(height: 10),
                              TextFormFieldWidget(
                                title: 'Custo da Diária:',
                                color: blue,
                                controller: state.controllerDailyCost,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Fotos do Veículo:',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const Text(
                            '(Selecione até 5 fotos)',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          state.carImages.isNotEmpty
                              ? SizedBox(
                                  height: 90,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (state.carImages.length >= 5)
                                        ? 5
                                        : state.carImages.length + 1,
                                    itemBuilder: (context, index) {
                                      if (state.carImages.length < 5 &&
                                          index >= state.carImages.length) {
                                        return IconButton(
                                          icon: Icon(Icons.add),
                                          color: Colors.white,
                                          onPressed: () async {
                                            await state
                                                .getImage(ImageSource.camera);
                                          },
                                        );
                                      }

                                      final carImage = state.carImages[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Stack(
                                            children: [
                                              Hero(
                                                tag: 'image$index',
                                                child: Image.file(
                                                  carImage,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    state.removeCarImage(index);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    height:
                                        MediaQuery.of(context).size.height / 5.5,
                                    color: orange,
                                    child: IconButton(
                                      onPressed: () async {
                                        await state.getImage(ImageSource.camera);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                if (state.keyFormVehicle.currentState!
                                    .validate()) {
                                  await state.insertVehicle();
                                  await state.saveImageFile();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Salvar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
