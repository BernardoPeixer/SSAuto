import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../controller/agency_controller.dart';
import '../controller/vehicle_controller.dart';
import '../model/agency_model.dart';
import '../model/brands_model.dart';
import '../model/models_model.dart';
import '../model/vehicle_model.dart';
import '../model/year_model.dart';

/// CREATING THE STATE OF THE VEHICLE REGISTRATION PAGE
class VehicleRegistrationState with ChangeNotifier {
  /// STATE BUILDER
  VehicleRegistrationState() {
    loadAgency();
  }

  /// KEY FORM
  final keyFormVehicle = GlobalKey<FormState>();

  final _controllerBrand = TextEditingController();

  /// GETTER BRAND CONTROLLER
  TextEditingController get controllerBrand => _controllerBrand;

  final _controllerAgency = TextEditingController();

  /// GETTER AGENCY CONTROLLER
  TextEditingController get controllerAgency => _controllerAgency;

  final _controllerModel = TextEditingController();

  /// GETTER MODEL CONTROLLER
  TextEditingController get controllerModel => _controllerModel;

  final _controllerLicensePlate = TextEditingController();

  /// GETTER LICENSE PLATE CONTROLLER
  TextEditingController get controllerLicensePlate => _controllerLicensePlate;

  final _controllerYear = TextEditingController();

  /// GETTER YEAR CONTROLLER
  TextEditingController get controllerYear => _controllerYear;

  final _controllerDailyCost = TextEditingController();

  /// GETTER DAILY COST CONTROLLER
  TextEditingController get controllerDailyCost => _controllerDailyCost;

  /// VEHICLE CONTROLLER FROM DATABASE
  final controllerVehicle = VehicleController();

  /// FUNCTION TO INSERT VEHICLE IN DATABASE
  Future<void> insertVehicle() async {
    final dailyCost = double.tryParse(controllerDailyCost.text);
    final vehicle = Vehicle(
      vehicleBrand: controllerBrand.text,
      vehicleModel: controllerModel.text,
      vehicleLicensePlate: controllerLicensePlate.text,
      vehicleYear: controllerYear.text,
      vehicleDailyCost: dailyCost!,
      agencyCode: selectedItem!.agencyId!,
      vehicleStats: 'Disponivel',
    );

    await controllerVehicle.insert(vehicle);
    notifyListeners();
  }

  /// FILE CAR IMAGES LIST
  final carImages = <File>[];

  /// FUNCTION TO GET IMAGES
  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final cropper = ImageCropper();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      final croppedFile = await cropper.cropImage(
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

  /// FUNCTION TO SAVE IMAGE FILE
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

    final imagePaths = <String>[];

    for (var i = 0; i < carImages.length; i++) {
      final carImage = carImages[i];
      final fileCar = File('${directoryCarsId.path}/$i.png');

      final bytes = await carImage.readAsBytes();
      await fileCar.writeAsBytes(bytes);

      imagePaths.add(fileCar.path);
    }
  }

  /// FUNCTION TO REMOVE IMAGE CAR
  void removeCarImage(int index) {
    carImages.removeAt(index);
    notifyListeners();
  }

  /// SELECTED BRAND IN TYPE AHEAD
  Brands? selectedBrand;

  /// SELECTED MODEL IN TYPE AHEAD
  Models? selectedModel;

  /// SELECTED YEAR IN TYPE AHEAD
  Year? selectedYear;

  /// VEHICLE BRANDS LIST
  List<Brands> brandsList = [];

  /// VEHICLE MODELS LIST
  List<Models> modelsList = [];

  /// VEHICLE YEAR LIST
  List<Year> yearList = [];

  /// FUNCTION TO GET BRAND FROM FIPE API
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

  /// FUNCTION TO GET MODELS FROM FIPE API
  Future<void> getModels() async {
    if (selectedBrand == null || selectedBrand!.code == null) {
      throw Exception('Selected brand or brand code is null');
    }

    modelsList.clear();

    final response = await http.get(
      Uri.parse(
          'https://fipe.parallelum.com.br/api/v2/cars/brands/${selectedBrand!.code}/models'),
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

  /// FUNCTION TO GET YEARS FROM FIPE API
  Future<void> getYears() async {
    if (selectedModel == null) {
      throw Exception('Selected brand or brand code is null');
    }

    yearList.clear();

    final response = await http.get(
      Uri.parse(
          'https://fipe.parallelum.com.br/api/v2/cars/brands/${selectedBrand!.code}/models/${selectedModel!.code}/years'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> listJson = jsonDecode(response.body);
      for (final it in listJson) {
        yearList.add(Year.fromJson(it));
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load years');
    }
  }

  /// FUNCTION TO SET BRAND
  void setBrand(Brands brand) {
    selectedBrand = brand;
    notifyListeners();
  }

  /// FUNCTION ON SELECTED BRAND IN TYPE AHEAD
  void onSelectedBrand(Brands suggestion) {
    controllerModel.text = '';
    controllerBrand.text = suggestion.name!.toUpperCase();
    selectedBrand = suggestion;
    notifyListeners();
  }

  /// FUNCTION ON SELECTED MODEL IN TYPE AHEAD
  void onSelectedModel(Models suggestion) {
    controllerModel.text = suggestion.name.toUpperCase();
    selectedModel = suggestion;
    notifyListeners();
  }

  /// FUNCTION ON SELECTED YEAR IN TYPE AHEAD
  void onSelectedYear(Year suggestion) {
    selectedYear = suggestion;
    controllerYear.text = selectedYear!.name;
    notifyListeners();
  }

  /// FUNCTION TO SHOW IMAGE SOURCE DIALOG
  Future<void> showImageSourceDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
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
                onTap: () async {
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

  /// CONTROLLER AGENCY FROM DATABASE
  final agencyController = AgencyController();
  final _listAgency = <Agency>[];

  /// GETTER LIST AGENCY
  List<Agency> get listAgency => _listAgency;

  /// FUNCTION TO LOAD AGENCYS FROM DATABASE
  Future<void> loadAgency() async {
    final list = await agencyController.selectAgency();
    _listAgency.clear();
    _listAgency.addAll(list);
    notifyListeners();
  }

  Agency? _selectedItem;

  /// GETTER SELECTED AGENCY
  Agency? get selectedItem => _selectedItem;

  /// FUNCTION ON SELECTED AGENCY IN TYPE AHEAD
  void onSelectAgency(Agency? agency) {
    _selectedItem = agency;
    notifyListeners();
  }
}
