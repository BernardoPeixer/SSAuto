import 'package:flutter/material.dart';

class FilterModelsWidget extends StatelessWidget {
  FilterModelsWidget({super.key});

  final List<int> lista = [1,2,3,4,5,6,7,8,9,10];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
        ),
        ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              ListTile(
                title: Text('${lista[index]}'),
              );
            }),
      ],
    );
  }
}
