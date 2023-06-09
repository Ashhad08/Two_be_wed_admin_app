// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class StorageServices {
  Future<String?> uploadImage({
    required ImageSource source,
    required BuildContext context,
    required int imageNumber,
  }) async {
    String? imagePath;
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      File file = File(image.path);
      UploadTask uploadTask = FirebaseStorage.instance
          .ref(
              'hall-images/${FirebaseAuth.instance.currentUser!.uid}/Image$imageNumber')
          .putFile(file);

      try {
        await uploadTask.whenComplete(() async {
          imagePath = await uploadTask.snapshot.ref.getDownloadURL();
        });
      } on firebase_core.FirebaseException catch (e) {
        if (e.code == 'unknown') {
          Utils.showSnackBar(
              context: context,
              message: 'Check your internet Connection',
              color: Colors.red);
        } else {
          Utils.showSnackBar(
              context: context, message: e.message ?? '', color: Colors.red);
        }
      }
    }
    return imagePath;
  }
}
