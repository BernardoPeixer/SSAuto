// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// class TypeAheadWidget extends StatelessWidget {
//   const TypeAheadWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadField(
//       suggestionsCallback: (search) => CityService.of(context).find(search),
//       builder: (context, controller, focusNode) {
//         return TextField(
//             controller: controller,
//             focusNode: focusNode,
//             autofocus: true,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: 'City',
//             )
//         );
//       },
//       itemBuilder: (context, city) {
//         return ListTile(
//           title: Text(city.name),
//           subtitle: Text(city.country),
//         );
//       },
//       onSelected: (item) {
//         controller == item;
//         );
//       },
//     )
//   }
// }
