import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/setting_repository_provider.dart';
import 'package:hr_self_service/src/domain/repository/setting_repository.dart';
import 'package:hr_self_service/src/ui/settings/setting_action.dart';
import 'package:hr_self_service/src/ui/settings/setting_state.dart';

class SettingViewModel extends Notifier<SettingState> {
  late final SettingRepository settingRepository;

  @override
  SettingState build() {
    _initiate();
    return SettingState();
  }

  void onAction(SettingAction action) {
    switch (action) {
      case OnPickingSeedColor():
        _updateSeedColor(action.newColor);
      case OnPickingFontFamily():
        _updateFontFamily(action.newFontFamily);
    }
  }

  void _updateSeedColor(Color newColor) {
    state = state.copy(
      newSetting: state.currentSetting.copy(seedColor: newColor)
    );

    settingRepository.saveSetting(state.currentSetting);
  }

  void _updateFontFamily(String newFontFamily) {
    state = state.copy(
      newSetting: state.currentSetting.copy(fontFamily: newFontFamily)
    );

    settingRepository.saveSetting(state.currentSetting);
  }

  void _initiate() async {
    settingRepository = ref.read(settingRepositoryProvider);
    final savedSetting = await settingRepository.getCurrentSetting();
    state = state.copy(newSetting: savedSetting);
  }
}