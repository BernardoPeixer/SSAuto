import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/agency_model.dart';
import '../states/agency_registration_state.dart';
import 'widgets/bottom_app_bar_widget.dart';
import 'widgets/type_ahead_managers_widget.dart';

/// CREATION OF STATELESS WIDGET
class AgencyRegistrationPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const AgencyRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final agencyId = ModalRoute.of(context)!.settings.arguments as int?;
    return ChangeNotifierProvider(
      create: (context) => AgencyRegistrationState(agencyId),
      child: Consumer<AgencyRegistrationState>(builder: (_, state, __) {
        return Scaffold(
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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      agencyId != null
                          ? 'EDITAR AGÊNCIA'
                          : 'CADASTRO DE AGÊNCIA',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Nome da agência:',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: 30,
                            child: TextFormField(
                              controller: state.controllerAgencyName,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 6.0),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Endereço:',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: 30,
                            child: TextFormField(
                              controller: state.controllerAgencyAddress,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 6.0),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Cidade:',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: 30,
                                  child: TextFormField(
                                    controller: state.controllerAgencyCity,
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
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Estado:',
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                height: 30,
                                child: TextFormField(
                                  controller: state.controllerAgencyState,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 6.0),
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Telefone:',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: 30,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [state.maskFormatterPhone],
                              controller: state.controllerAgencyPhone,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 6.0),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          'Gerente:',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: TypeAheadManagersWidget(
                            controller: state.controllerAgencyManager,
                            managerList: state.listManager,
                            onSelectManager: state.onManagerSelect,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          side: const BorderSide(color: Colors.white, width: 1),
                        ),
                        onPressed: () async {
                            if (agencyId != null) {
                              final agencyToUpdate = Agency(
                                agencyName: state.controllerAgencyName.text,
                                agencyState: state.controllerAgencyState.text,
                                agencyCity: state.controllerAgencyCity.text,
                                agencyPhone: state.controllerAgencyPhone.text,
                                agencyAddress:
                                    state.controllerAgencyAddress.text,
                                managerCode: state.selectedManager!.managerId,
                                agencyId: agencyId,
                              );
                              state.updateAgency(agencyToUpdate);
                            } else {
                              await state.insertAgency();
                            }
                            Navigator.pushNamed(
                                context, '/managerCustomerPage');
                        },
                        child: Text(
                          agencyId != null ? 'EDITAR' : 'CADASTRAR',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
