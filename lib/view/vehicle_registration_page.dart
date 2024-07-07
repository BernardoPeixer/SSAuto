import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ss_auto/states/vehicle_registration_state.dart';
import 'package:ss_auto/view/widgets/add_photos_button_widget.dart';
import 'package:ss_auto/view/widgets/agency_dropdown_widget.dart';
import 'package:ss_auto/view/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/view/widgets/type_ahead_brands_widget.dart';

import '../model/agency_model.dart';
import '../model/brands_model.dart';
import '../model/models_model.dart';

import '../model/year_model.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/type_ahead_models_widget.dart';

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
            backgroundColor: const Color(0xFFca122e),
            appBar: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFFca122e),
              actions: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              padding: const EdgeInsets.all(5),
              child: Form(
                key: state.keyFormVehicle,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CADASTRO DE VEÍCULO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            'SELECIONE ATÉ 5 FOTOS',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          AddPhotosButtonWidget(
                              carImages: state.carImages,
                              showImageSourceDialog:
                                  state.showImageSourceDialog,
                              removeCarImage: state.removeCarImage),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'MARCA',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                                width: 240,
                                child: TypeAheadBrandsWidget(
                                  controller: state.controllerBrand,
                                  getBrands: state.getBrands,
                                  getModels: state.getModels,
                                  onBrandSelected: (Brands brand) {
                                    state.setBrand(brand);
                                    state.getModels();
                                  },
                                  brandsList: state.brandsList,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'MODELO',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                                width: 240,
                                child: TypeAheadModelsWidget(
                                  controller: state.controllerModel,
                                  modelsList: state.modelsList,
                                  getModels: state.getModels,
                                  onModelSelected: (Models model) {
                                    state.selectedModel = model;
                                    state.getYears();
                                  },
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'PLACA',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                width: 90,
                                height: 30,
                                child: TextFormField(
                                  controller: state.controllerLicensePlate,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(5.0),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 0.0, horizontal: 6.0),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const Text(
                                'ANO',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  color: Colors.white,
                                ),
                                child: DropdownButton<Year>(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  value: state.selectedYear,
                                  dropdownColor: blue,
                                  underline:
                                      const DropdownButtonHideUnderline(
                                    child: Text(''),
                                  ),
                                  iconEnabledColor: Colors.white,
                                  onChanged: (Year? year) {
                                    state.onSelectedYear(year!);
                                  },
                                  items: [
                                    ...state.yearList.map((Year year) {
                                      return DropdownMenuItem<Year>(
                                        value: year,
                                        child: Text(
                                          year.name,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          TextFormFieldWidget(
                            title: 'Custo da diária:',
                            color: blue,
                            controller: state.controllerDailyCost,
                          ),
                          Column(
                            children: [
                              const Text(
                                'Selecione a agência:',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                              AgencyDropdownWidget(
                                list: state.listAgency,
                                onChanged: (Agency? newAgency) {
                                  state.onChangedDropdown(newAgency);
                                },
                                selectedItem: state.selectedItem,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              side: const BorderSide(
                                  color: Colors.white, width: 1),
                            ),
                            onPressed: () async {
                              await state.insertVehicle();
                              await state.saveImageFile();
                              Navigator.pushNamed(context, '/fleetPage');
                            },
                            child: const Text(
                              'CADASTRAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
            bottomNavigationBar: Container(
              color: const Color(0xFFca122e),
              height: 80,
              child: const BottomAppBarWidget(),
            ),
          );
        },
      ),
    );
  }
}
