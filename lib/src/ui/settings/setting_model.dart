import 'package:flutter/material.dart';

class SettingModel {
  final Color seedColor;
  final String fontFamily;

  SettingModel({required this.seedColor, required this.fontFamily});

  SettingModel copy({Color? seedColor, String? fontFamily}) {
    return SettingModel(
      seedColor: seedColor ?? this.seedColor,
      fontFamily: fontFamily ?? this.fontFamily
    );
  }
}