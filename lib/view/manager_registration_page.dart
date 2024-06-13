import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/states/manager_registration_state.dart';
import 'package:ss_auto/view/widgets/text_form_field_widget.dart';

class ManagerRegistrationPage extends StatelessWidget {
  const ManagerRegistrationPage({super.key});

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
                      TextFormFieldWidget(title: 'Nome Completo:', color: orange,controller: state.controllerManagerName),
                      TextFormFieldWidget(title: 'Cidade:', color: orange,controller: state.controllerManagerCity),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'CPF:', color: orange, controller: state.controllerManagerCpf),
                      TextFormFieldWidget(title: 'Estado:', color: orange,controller: state.controllerManagerState),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormFieldWidget(title: 'E-mail:', color: blu, controller: state.controllerManagerEmail,),
                      TextFormFieldWidget(title: 'Telefone:', color: blu,controller: state.controllerManagerPhone),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(orange),
                      ),
                      onPressed: () async {

                          await state.insertManager();
                          Navigator.of(context).pushReplacementNamed('/managerCustomerPage');

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
