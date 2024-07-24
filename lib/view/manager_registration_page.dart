import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/manager_model.dart';
import '../states/manager_registration_state.dart';
import 'widgets/bottom_app_bar_widget.dart';

/// CREATION OF STATELESS WIDGET
class ManagerRegistrationPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const ManagerRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final managerId = ModalRoute.of(context)!.settings.arguments as int?;

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
      body: ChangeNotifierProvider(
        create: (context) => ManagerRegistrationState(managerId),
        child: Consumer<ManagerRegistrationState>(builder: (_, state, __) {
          return Form(
            key: state.keyFormManager,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        managerId == null
                            ? 'CADASTRO DE GERENTE'
                            : 'EDITAR GERENTE',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Nome completo:',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1,
                              height: 30,
                              child: TextFormField(
                                controller: state.controllerManagerName,
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
                                      controller: state.controllerManagerCity,
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
                                      style:
                                          const TextStyle(color: Colors.black),
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
                                    controller: state.controllerManagerState,
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
                                    'CPF:',
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
                                      controller: state.controllerManagerCpf,
                                      inputFormatters: [state.maskFormatterCpf],
                                      keyboardType: TextInputType.number,
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Comissão:',
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
                                    keyboardType: TextInputType.number,
                                    controller:
                                        state.controllerManagerCommission,
                                    decoration: InputDecoration(
                                      filled: true,
                                      suffix: const Text('%'),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Email:',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1,
                              height: 30,
                              child: TextFormField(
                                controller: state.controllerManagerEmail,
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
                              'Telefone',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1,
                              height: 30,
                              child: TextFormField(
                                controller: state.controllerManagerPhone,
                                inputFormatters: [state.maskFormatterPhone],
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
                            side:
                                const BorderSide(color: Colors.white, width: 1),
                          ),
                          onPressed: () async {
                            if (managerId != null) {
                              final managerToUpdate = Manager(
                                managerId: managerId,
                                managerName: state.controllerManagerName.text,
                                managerCity: state.controllerManagerCity.text,
                                managerCpf: state.controllerManagerCpf.text,
                                managerState: state.controllerManagerState.text,
                                managerPhone: state.controllerManagerPhone.text,
                                managerCommission: int.parse(
                                    state.controllerManagerCommission.text),
                                managerEmail: state.controllerManagerEmail.text,
                              );
                              await state.updateManager(managerToUpdate);
                            } else {
                              await state.insertManager();
                            }
                            Navigator.of(context)
                                .pushReplacementNamed('/managerCustomerPage');
                          },
                          child: Text(
                            managerId == null ? 'CADASTRAR' : 'EDITAR',
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
          );
        }),
      ),
      bottomNavigationBar: const SizedBox(
        height: 80,
        child: BottomAppBarWidget(),
      ),
    );
  }
}
