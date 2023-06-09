import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return null;
  }
}
