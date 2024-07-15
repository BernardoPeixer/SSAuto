import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/customer_registration_state.dart';

import 'widgets/bottom_app_bar_widget.dart';

/// CREATION OF STATELESS WIDGET
class CustomerRegistrationPage extends StatelessWidget {
  /// STATELESS WIDGET BUILDER
  const CustomerRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ChangeNotifierProvider(
        create: (context) => CustomerRegistrationState(),
        child: Consumer<CustomerRegistrationState>(builder: (_, state, __) {
          return Form(
            key: state.keyFormCustomer,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'CADASTRO DE CLIENTE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          inputFormatters: [state.maskFormatterCnpj],
                          keyboardType: TextInputType.number,
                          controller: state.controllerCnpj,
                          decoration: InputDecoration(
                            hintText: '00.000.000/0000-00',
                            hintStyle: const TextStyle(fontSize: 12),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 30.0,
                            ),
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search, size: 16,),
                              onPressed: () async {
                                await state.validatorCnpj();
                                await state.setCompanyDetails();
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: state.isValid == false,
                    child: const Text(
                      '*CNPJ inválido!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      visible: state.isValid == true,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(color: Colors.white)
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.customerCompanyName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'CNPJ: ${state.formatCnpj()}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    'Fone: ${state.formatPhone()}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    'Cidade: ${state.customerCompanyCity}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    'Status: ${state.customerCompanyActivity}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                await state.insertCustomer();
                                Navigator.of(context)
                                    .pushNamed('/managerCustomerPage');
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
                    ),
                  ),
                ],
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
