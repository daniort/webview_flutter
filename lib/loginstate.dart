
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginState with ChangeNotifier {


bool _loading = false;

isloading()=> _loading;

 offLoading() {
    _loading = false;
    notifyListeners();
  }

  onLoading() {
    _loading = true;
    notifyListeners();
  }

}