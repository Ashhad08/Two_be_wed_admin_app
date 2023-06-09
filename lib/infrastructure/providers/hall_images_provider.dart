import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/storage_services.dart';

class HallImagesProvider extends ChangeNotifier {
  bool _firstImageLoading = false;
  bool _secondImageLoading = false;
  bool _thirdImageLoading = false;
  bool _fourthImageLoading = false;
  String? _firstImage;
  String? _secondImage;
  String? _thirdImage;
  String? _fourthImage;

  bool get firstImageLoading => _firstImageLoading;

  bool get secondImageLoading => _secondImageLoading;

  bool get thirdImageLoading => _thirdImageLoading;

  bool get fourthImageLoading => _fourthImageLoading;

  String? get firstImage => _firstImage;

  String? get secondImage => _secondImage;

  String? get thirdImage => _thirdImage;

  String? get fourthImage => _fourthImage;
  final StorageServices _storageServices = StorageServices();

  Future<void> hallFirstImage(BuildContext context,
      {required ImageSource source}) async {
    _firstImageLoading = true;
    notifyListeners();
    _firstImage = await _storageServices.uploadImage(
        source: source, context: context, imageNumber: 1);
    _firstImageLoading = false;
    notifyListeners();
  }

  Future<void> hallSecondImage(BuildContext context,
      {required ImageSource source}) async {
    _secondImageLoading = true;
    notifyListeners();
    _secondImage = await _storageServices.uploadImage(
        source: source, context: context, imageNumber: 2);
    _secondImageLoading = false;
    notifyListeners();
  }

  Future<void> hallThirdImage(BuildContext context,
      {required ImageSource source}) async {
    _thirdImageLoading = true;
    notifyListeners();
    _thirdImage = await _storageServices.uploadImage(
        source: source, context: context, imageNumber: 3);
    _thirdImageLoading = false;
    notifyListeners();
  }

  Future<void> hallFourthImage(BuildContext context,
      {required ImageSource source}) async {
    _fourthImageLoading = true;
    notifyListeners();
    _fourthImage = await _storageServices.uploadImage(
        source: source, context: context, imageNumber: 4);
    _fourthImageLoading = false;
    notifyListeners();
  }
}
