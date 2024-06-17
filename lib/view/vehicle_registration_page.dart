import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';
import 'package:ss_auto/view/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/view/widgets/type_ahead_widget.dart';

class VehicleRegistrationPage extends StatelessWidget {
  const VehicleRegistrationPage({
    super.key,
  });

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
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: blue,
              centerTitle: true,
              title: const Text(
                '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: state.keyFormVehicle,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.car_rental,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                ),
                                Text(
                                  'Cadastro de veículo',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Text('Marca:', style: TextStyle(fontSize: 14.0, color: Colors.white),),
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: TypeAheadWidget(),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                            ),
                            TextFormFieldWidget(
                              title: 'Modelo:',
                              color: blue,
                              controller: state.controllerModel,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      'Placa:',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 30,
                                      child: TextFormField(
                                        controller:
                                            state.controllerLicensePlate,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: blue,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.blue, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0.0,
                                                  horizontal: 6.0),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      'Ano:',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height: 30,
                                      child: TextFormField(
                                        controller: state.controllerYear,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: blue,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.blue, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0.0,
                                                  horizontal: 6.0),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                            ),
                            TextFormFieldWidget(
                              title: 'Custo da diária:',
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
                                        icon: const Icon(Icons.add),
                                        color: Colors.white,
                                        onPressed: () async {
                                          await state
                                              .getImage(ImageSource.camera);
                                        },
                                      );
                                    }

                                    final carImage = state.carImages[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
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
                              await state.insertVehicle();
                              await state.saveImageFile();
                              Navigator.pop(context);
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
          );
        },
      ),
    );
  }
}
