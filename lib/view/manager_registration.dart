import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/manager_registration_state.dart';
import 'package:ss_auto/view/widgets/text_form_field_widget.dart';

class ManagerRegistration extends StatelessWidget {
  const ManagerRegistration({super.key});

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
          'Cadastro de Gerente',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => ManagerRegistrationState(),
        child: Consumer<ManagerRegistrationState>(
          builder: (_,state,__) {
            return Form(
              key: state.keyFormManager,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.supervisor_account,
                    size: 150,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'Nome Completo:', color: orange),
                      TextFormFieldWidget(title: 'Cidade:', color: orange),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'CPF:', color: orange),
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
                        if (state.keyFormManager.currentState!
                            .validate()) {
                          await state.insertManager();
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
