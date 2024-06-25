import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ss_auto/controller/vehicle_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import '../model/brands_model.dart';
import '../model/models_model.dart';
import '../model/vehicle_model.dart';
import 'package:http/http.dart' as http;

class VehicleRegistrationState with ChangeNotifier {
  VehicleRegistrationState({this.vehicle});

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
      vehicleBrand: controllerBrand.text,
      vehicleModel: controllerModel.text,
      vehicleLicensePlate: controllerLicensePlate.text,
      vehicleYear: controllerYear.text,
      vehicleDailyCost: controllerDailyCost.text,
    );

    await controllerVehicle.insert(vehicle);
    notifyListeners();
    print('insert concluido');
  }

  List<File> carImages = [];

  Future<void> getImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    ImageCropper cropper = ImageCropper();
    XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      CroppedFile? croppedFile = await cropper.cropImage(
        sourcePath: image.path,
        compressQuality: 100,
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

  Brands? selectedBrand;
  Models? selectedModel;
  List<Brands> brandsList = [];
  List<Models> modelsList = [];

  Future<void> getBrands() async {
    brandsList.clear();

    final response = await http.get(
      Uri.parse('https://fipe.parallelum.com.br/api/v2/cars/brands'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> listJson = jsonDecode(response.body);
      for (final it in listJson) {
        brandsList.add(Brands.fromJson(it));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load brands');
    }
  }

  Future<void> getModels() async {
    if (selectedBrand == null || selectedBrand!.code == null) {
      throw Exception('Selected brand or brand code is null');
    }

    modelsList.clear();

    final response = await http.get(
      Uri.parse('https://fipe.parallelum.com.br/api/v2/cars/brands/${selectedBrand!.code}/models'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> listJson = jsonDecode(response.body);
      for (final it in listJson) {
        modelsList.add(Models.fromJson(it));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load models');
    }
  }

  void setBrand(brand) {
    selectedBrand = brand;
    notifyListeners();
  }

  void onSelectedBrand(Brands suggestion) {
    controllerModel.text = '';
    controllerBrand.text = suggestion.name!.toUpperCase();
    selectedBrand = suggestion;
    notifyListeners();
  }

  void onSelectedModel(Models suggestion) {
    controllerModel.text = suggestion.name.toUpperCase();
    selectedModel = suggestion;
    notifyListeners();
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Escolha a origem da imagem'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () async {
                  await getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () async{
                  await getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}
