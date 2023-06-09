import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/infrastructure/models/admin_model.dart';
import 'package:two_be_wedd/utils/backend_configs.dart';

import '../../utils/utils.dart';
import '../models/hall_model.dart';
import '../providers/loading_helper.dart';

class AdminServices {
  Future registerAdmin(
      {required AdminModel adminModel, required BuildContext context}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      return await BackEndConfigs.adminsCollectionsRef
          .doc(adminModel.id)
          .set(adminModel.toJson());
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }

  Future updateAdminNotificationToken({
    required BuildContext context,
    required String? token,
    required String uid,
  }) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      return await BackEndConfigs.adminsCollectionsRef.doc(uid).update({
        "notificationToken": token,
      });
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }

  Future<void> allHall(
      {required HallModel hallModel, required BuildContext context}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      DocumentReference ref = BackEndConfigs.hallsCollectionsRef.doc();
      return await ref.set(hallModel.toJson(ref.id));
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: e.message ?? '',
          color: Theme.of(context).colorScheme.error);
      return;
    }
  }
}
