import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SelectedPageProvider extends ChangeNotifier {
  final UniqueKey _navigatorKey = UniqueKey();

  int _selectedPage = 0;
  int _previousIndex = 0;

  void changePage(int index) {
    _previousIndex = _selectedPage;
    _selectedPage = index;
    notifyListeners();
  }

  get selectedPage => _selectedPage;

  get navigatorKey => _navigatorKey;

  void setPreviousIndex() {
    _selectedPage = _previousIndex;
    notifyListeners();
  }
}
