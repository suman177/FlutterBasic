import 'package:flutter/material.dart';

class SelectionProvider with ChangeNotifier {
  int _totalBoxes = 0;
  int _maxAllowedSelection = 0;
  int _maxAlphaAllowed = 0;
  int _maxNumberAllowed = 0;

  //Getters
  int get totalBoxes => _totalBoxes;
  int get maxAllowedSelection => _maxAllowedSelection;
  int get maxAlphaAllowed => _maxAlphaAllowed;
  int get maxNumberAllowed => _maxNumberAllowed;

  //Hold all the selected Indexes
  List<bool> _selectedAlpha = [];
  List<bool> _selectedNumbers = [];

  //Count Selected Alpha Number
  //Reduces time complexity to constant time
  int _countSelectedAlpha = 0;
  int _countSelectedNumbers = 0;

  void reinitializeCountSelected() {
    _countSelectedAlpha = 0;
    _countSelectedNumbers = 0;
  }

  // Setter for total max.
  set totalBoxes(int boxes) {
    _totalBoxes = boxes;
    reinitializeCountSelected();
    _selectedAlpha = List.generate(boxes, (index) => false);
    _selectedNumbers = List.generate(boxes, (index) => false);
    notifyListeners();
  }

  // Setter for total max max allowd selection
  set maxAllowedSelection(int selections) {
    _maxAllowedSelection = selections;
    notifyListeners();
  }

  // Setters for total max max allowd selection
  set maxAlphaAllowed(int maxAlp) {
    _maxAlphaAllowed = maxAlp;
    notifyListeners();
  }

  set maxNumberAllowed(int maxNum) {
    _maxNumberAllowed = maxNum;
    notifyListeners();
  }

  //If true we can select other alphabets or not.
  //-1 because index count starts from 0
  bool isMaxAlphaValid() {
    print(
        _countSelectedAlpha.toString() + "    " + _maxAlphaAllowed.toString());
    return _countSelectedAlpha <= _maxAlphaAllowed - 1;
  }

  //If true we can select other numbers else not.
  //-1 because index count starts from 0
  bool isMaxNumberValid() {
    print(_countSelectedNumbers.toString() +
        "    " +
        _maxNumberAllowed.toString());
    return _countSelectedNumbers <= _maxNumberAllowed - 1;
  }

  //Check particulat alpha
  void selectedNumber(int index, bool value) {
    if (value) {
      _countSelectedNumbers++;
    } else {
      _countSelectedNumbers--;
    }
    _selectedNumbers[index] = value;
  }

  //Check particulat number
  void selectAlpha(int index, bool value) {
    if (value) {
      _countSelectedAlpha++;
    } else {
      _countSelectedAlpha--;
    }
    _selectedAlpha[index] = value;
  }

  //Check if index is selected.
  bool isSelectedAlpha(int index) {
    return _selectedAlpha[index];
  }

  //Check if index is selected.
  bool isSelectedNumber(int index) {
    return _selectedNumbers[index];
  }

  //Check if total selecteion is reached
  bool isValidMaxAllowedSelection() {
    return (_countSelectedAlpha + _countSelectedNumbers) <=
        _maxAllowedSelection - 1;
  }
}
