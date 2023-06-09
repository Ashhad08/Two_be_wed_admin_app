import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../infrastructure/providers/loading_helper.dart';

class CustomLoadingOverlay extends StatelessWidget {
  const CustomLoadingOverlay({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: Provider.of<LoadingHelper>(context).getStateStatus() ==
          StateStatus.IsBusy,
      opacity: 1,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}
