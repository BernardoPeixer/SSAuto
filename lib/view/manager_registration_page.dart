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
        child: Consumer<ManagerRegistrationState>(builder: (_, state, __) {
          return Scaffold(
            backgroundColor: blue,
            body: SingleChildScrollView(
              child: Form(
                key: state.keyFormManager,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.supervisor_account,
                        size: 150,
                        color: Colors.white,
                      ),
                      TextFormFieldWidget(
                          title: 'Nome Completo:',
                          color: orange,
                          controller: state.controllerManagerName),
                      TextFormFieldWidget(
                          title: 'Cidade:',
                          color: orange,
                          controller: state.controllerManagerCity),
                      const Text(
                        'CPF:',
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 30,
                        child: TextFormField(
                          inputFormatters: [state.maskFormatterCpf],
                          controller: state.controllerManagerCpf,
                          decoration: InputDecoration(
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
                      TextFormFieldWidget(
                          title: 'Estado:',
                          color: orange,
                          controller: state.controllerManagerState),
                      TextFormFieldWidget(
                        title: 'E-mail:',
                        color: blu,
                        controller: state.controllerManagerEmail,
                      ),
                      TextFormFieldWidget(
                          title: 'Telefone:',
                          color: blu,
                          controller: state.controllerManagerPhone),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(orange),
                          ),
                          onPressed: () async {
                            await state.insertManager();
                            Navigator.of(context)
                                .pushReplacementNamed('/managerCustomerPage');
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
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
