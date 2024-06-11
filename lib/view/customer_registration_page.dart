import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/customer_registration_state.dart';

class CustomerRegistrationPage extends StatelessWidget {
  const CustomerRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color blue = const Color(0xff011329);
    Color blu = const Color(0xff052b57);
    Color orange = const Color(0xffD3393A);

    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        backgroundColor: blu,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Cadastro de Cliente',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => CustomerRegistrationState(),
        child: Consumer<CustomerRegistrationState>(builder: (_, state, __) {
          return Form(
            key: state.keyFormCustomer,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.person,
                  size: 150,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'CNPJ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormField(
                        inputFormatters: [state.maskFormatterCnpj],
                        keyboardType: TextInputType.number,
                        controller: state.controllerCnpj,
                        decoration: InputDecoration(
                          hintText: '00.000.000/0000-00',
                          filled: true,
                          fillColor: orange,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 6.0),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await state.setCompanyDetails();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: state.visible,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            state.customerCompanyName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CNPJ: ${state.customerCompanyCnpj}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Fone: ${state.customerCompanyPhone}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Cidade: ${state.customerCompanyCity} / ${state.customerCompanyState}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            'Status: ${state.customerCompanyActivity}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
