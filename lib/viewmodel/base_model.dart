import 'package:flutter/widgets.dart';
import 'package:flutter_banking/model/viewstate.dart';

class BaseModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;

  setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}