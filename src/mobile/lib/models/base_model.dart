import 'package:app/enums/ServerState.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  ServerState _state = ServerState.Idle;

  ServerState get state => _state;

  void setState(ServerState newState) {
    _state = newState;
    notifyListeners();
  }
}
