import 'package:flutter/material.dart';

class NotificationsNotifier extends ChangeNotifier {
  init() async {
    //todo: get notifications from server

    notifyListeners();
  }
}
