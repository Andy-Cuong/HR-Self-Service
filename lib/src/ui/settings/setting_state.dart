import 'package:flutter/material.dart';
import 'package:hr_self_service/src/ui/settings/setting_model.dart';

class SettingState {
  final SettingModel currentSetting;

  SettingState({
    SettingModel? currentSetting,
  }) : currentSetting = currentSetting ?? SettingModel(
    seedColor: Colors.deepPurple, fontFamily: 'Roboto'
  );

  SettingState copy({
    SettingModel? newSetting
  }) => SettingState(
    currentSetting: newSetting ?? currentSetting
  );
}