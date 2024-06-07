import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/customer_registration_state.dart';

import 'widgets/text_form_field_widget.dart';

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
        child: Consumer<CustomerRegistrationState>(
          builder: (_, state, __) {
            return Form(
              key: state.keyFormCustomer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.person,
                    size: 150,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'Nome da Empresa:', color: orange),
                      TextFormFieldWidget(title: 'Cidade:', color: orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'CNPJ:', color: orange),
                      TextFormFieldWidget(title: 'Estado:', color: orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'E-mail:', color: blu),
                      TextFormFieldWidget(title: 'Telefone:', color: blu),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(orange),
                      ),
                      onPressed: () async {
                        if (state.keyFormCustomer.currentState!
                            .validate()) {
                          await state.insertCustomer();
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
              ),
            );
          }
        ),
      ),
    );
  }
}
