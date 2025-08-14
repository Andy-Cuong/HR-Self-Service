import 'package:flutter/material.dart';

sealed class SettingAction {}

class OnPickingSeedColor extends SettingAction {
  final Color newColor;

  OnPickingSeedColor(this.newColor);
}

class OnPickingFontFamily extends SettingAction {
  final String newFontFamily;

  OnPickingFontFamily(this.newFontFamily);
}