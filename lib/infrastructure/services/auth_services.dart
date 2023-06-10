import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/presentation/views/admin_auth_view/admin_auth_view.dart';
import 'package:two_be_wedd/utils/navigation_helper.dart';

import '../../utils/utils.dart';
import '../providers/loading_helper.dart';

class AuthServices {
  Future<UserCredential?> register(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      if (e.code == 'unknown') {
        Utils.showSnackBar(
            context: context,
            message: 'Check your internet Connection',
            color: Theme.of(context).colorScheme.error);
        return null;
      } else {
        Utils.showSnackBar(
            context: context,
            message: e.message ?? '',
            color: Theme.of(context).colorScheme.error);
        return null;
      }
    }
  }

  Future<UserCredential?> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      loadingProvider.stateStatus(StateStatus.IsError);
      if (e.code == 'unknown') {
        Utils.showSnackBar(
            context: context,
            message: 'Check your internet Connection',
            color: Theme.of(context).colorScheme.error);
        return null;
      } else {
        Utils.showSnackBar(
            context: context,
            message: e.message ?? '',
            color: Theme.of(context).colorScheme.error);
        return null;
      }
    }
  }

  Future<void> logOut(BuildContext context) async {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);
    loadingProvider.stateStatus(StateStatus.IsBusy);
    await FirebaseAuth.instance.signOut().then((value) {
      loadingProvider.stateStatus(StateStatus.IsFree);
      NavigationHelper.pushReplacement(context, const AdminAuthView());
    }).onError((error, stackTrace) {
      loadingProvider.stateStatus(StateStatus.IsFree);
      Utils.showSnackBar(
          context: context,
          message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
          color: Theme.of(context).colorScheme.error);
    });
  }
}
