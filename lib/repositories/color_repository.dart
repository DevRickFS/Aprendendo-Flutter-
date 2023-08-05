import 'dart:math';

import 'package:flutter/material.dart';

class ColorRepository extends ChangeNotifier{
  Color color = Colors.blue;

  setColor(){
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    notifyListeners();
  }
}