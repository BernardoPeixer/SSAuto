import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ss_auto/view/widgets/text_form_field_widget.dart';

import '../states/agency_registration_state.dart';

class AgencyRegistrationPage extends StatelessWidget {
  const AgencyRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AgencyRegistrationState(),
      child: Consumer<AgencyRegistrationState>(builder: (_, state, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFca122e),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormFieldWidget(
                  title: 'Nome da agencia',
                  controller: state.controllerAgencyName,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormFieldWidget(
                  title: 'Cidade',
                  controller: state.controllerAgencyCity,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormFieldWidget(
                  title: 'Estado',
                  controller: state.controllerAgencyState,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  state.insertAgency();
                  Navigator.pop(context);
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
