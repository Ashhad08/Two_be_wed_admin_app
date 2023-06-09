import 'package:flutter/foundation.dart';

enum StateStatus { IsBusy, IsFree, IsError }

class LoadingHelper with ChangeNotifier {
  StateStatus _status = StateStatus.IsFree;

  void stateStatus(StateStatus status) {
    _status = status;
    notifyListeners();
  }

  getStateStatus() => _status;
}
