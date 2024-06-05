import 'package:flutter/material.dart';

import 'widgets/textFormFieldModel.dart';

class CustomerRegistration extends StatelessWidget {
  const CustomerRegistration({super.key});

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
      body: Column(
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
              TextFormFieldModel(title: 'Nome da Empresa:', color: orange),
              TextFormFieldModel(title: 'Cidade:', color: orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormFieldModel(title: 'CNPJ:', color: orange),
              TextFormFieldModel(title: 'Estado:', color: orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormFieldModel(title: 'E-mail:', color: blu),
              TextFormFieldModel(title: 'Telefone:', color: blu),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(orange),
              ),
              onPressed: () {},
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
}
