import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/controller/vehicle_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import '../model/vehicle_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class VehicleRegistrationState with ChangeNotifier {
  VehicleRegistrationState({this.vehicle}) {
    loadVehicle();
    getBrands();
  }

  bool isPressedYesButton = false;
  bool isPressedNoButton = false;
  final keyFormVehicle = GlobalKey<FormState>();

  final _controllerBrand = TextEditingController();

  TextEditingController get controllerBrand => _controllerBrand;

  final _controllerModel = TextEditingController();

  TextEditingController get controllerModel => _controllerModel;

  final _controllerLicensePlate = TextEditingController();

  TextEditingController get controllerLicensePlate => _controllerLicensePlate;

  final _controllerYear = TextEditingController();

  TextEditingController get controllerYear => _controllerYear;

  final _controllerCategory = TextEditingController();

  TextEditingController get controllerCategory => _controllerCategory;

  final _controllerDailyCost = TextEditingController();

  TextEditingController get controllerDailyCost => _controllerDailyCost;

  final _controllerMileage = TextEditingController();

  TextEditingController get controllerMileage => _controllerMileage;

  final _controllerColor = TextEditingController();

  TextEditingController get controllerColor => _controllerColor;

  final String controllerAir = 'yes';

  final String controllerSensor = 'yes';

  final controllerVehicle = VehicleController();

  final Vehicle? vehicle;

  final _listVehicles = <Vehicle>[];

  List<Vehicle> get listVehicles => _listVehicles;

  String? name(String? value) {
    if (value == null || value.length < 5) {
      return 'O nome deve conter mais de 5 letras';
    }
    return null;
  }

  void pressedNoButton() {
    isPressedNoButton = true;
    isPressedYesButton = false;
    notifyListeners();
  }

  void pressedYesButton() {
    isPressedYesButton = true;
    isPressedNoButton = false;
    notifyListeners();
  }

  Future<void> insertVehicle() async {
    print('chamando insert');
    final vehicle = Vehicle(
      brand: controllerBrand.text,
      model: controllerModel.text,
      licensePlate: controllerLicensePlate.text,
      year: controllerYear.text,
      dailyCost: controllerDailyCost.text,
    );

    await controllerVehicle.insert(vehicle);
    notifyListeners();
    print('insert concluido');
  }

  void addVehicle(Vehicle vehicle) {
    _listVehicles.add(vehicle);
    notifyListeners();
  }

  void deleteVehicle(Vehicle vehicle) {
    _listVehicles.remove(vehicle);
    notifyListeners();
  }

  Future<void> loadVehicle() async {
    final list = await controllerVehicle.selectVehicles();
    _listVehicles.clear();
    _listVehicles.addAll(list);
    notifyListeners();
  }

  List<File> carImages = [];

  Future<void> getImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    ImageCropper cropper = ImageCropper();
    XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      CroppedFile? croppedFile = await cropper.cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxHeight: 100,
        maxWidth: 100,
        compressFormat: ImageCompressFormat.jpg,
      );

      if (croppedFile != null) {
        carImages.add(File(croppedFile.path));
      }

      notifyListeners();
    }
  }

  Future<void> saveImageFile() async {
    final appDocumentsDir = await getApplicationSupportDirectory();

    final pathImages = '${appDocumentsDir.path}/images';
    final directoryImages = Directory(pathImages);

    if (!directoryImages.existsSync()) {
      await directoryImages.create();
    }

    final pathCars = '${appDocumentsDir.path}/images/cars';
    final directoryCars = Directory(pathCars);

    if (!directoryCars.existsSync()) {
      await directoryCars.create();
    }

    final directoryNameVehicle = _controllerLicensePlate.text.trim();

    final pathIdCars = '${directoryCars.path}/$directoryNameVehicle';

    final directoryCarsId = Directory(pathIdCars);

    if (!directoryCarsId.existsSync()) {
      await directoryCarsId.create();
    }

    try {
      for (int i = 0; i < carImages.length; i++) {
        final carImage = carImages[i];
        final fileCar = File('${directoryCarsId.path}/$i.png');

        final bytes = await carImage.readAsBytes();

        await fileCar.writeAsBytes(bytes);
      }
    } catch (e, trace) {
      print('error: $e, $trace');
    }
  }

  void removeCarImage(int index) {
    carImages.removeAt(index);
    notifyListeners();
  }

  Future<Map<String, String>> getBrands() async {
    final response = await http.get(
      Uri.parse('https://fipe.parallelum.com.br/api/v2/cars/brands'),
      headers: {},
    );

    final decoded = jsonDecode(response.body);

    Map<String, String> brandMap = {};

    for (var brand in decoded) {
      String brandCode = brand['code'];
      String brandName = brand['name'];
      brandMap[brandCode] = brandName;
    }

    print('Mapa de Marcas:');
    brandMap.forEach((code, name) {
      print('$code: $name');
    });

    return brandMap;
  }

  Future<List<String>> getBrandsTest(String pattern) async {
    final response = await http.get(
      Uri.parse('https://fipe.parallelum.com.br/api/v2/cars/brands'),
      headers: {},
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List<String> brands = [];

      for (var brand in decoded) {
        String brandName = brand['name'];
        if (brandName.toLowerCase().contains(pattern.toLowerCase())) {
          brands.add(brandName);
        }
      }

      return brands;
    } else {
      throw Exception('Failed to load brands');
    }
  }

  void setControllerBrand(brand) {
   controllerBrand == brand;
   notifyListeners();
  }
}
