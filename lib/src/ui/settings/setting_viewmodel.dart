import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/domain/repository/setting_repository.dart';
import 'package:hr_self_service/src/ui/settings/setting_action.dart';
import 'package:hr_self_service/src/ui/settings/setting_provider.dart';
import 'package:hr_self_service/src/ui/settings/setting_state.dart';

class SettingViewModel extends StateNotifier<SettingState> {
  final Ref ref;
  final SettingRepository settingRepository;

  SettingViewModel(this.ref, this.settingRepository) : super(SettingState()) {
    _initiate();
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
    ref.read(settingProvider.notifier).state = state.currentSetting;

    settingRepository.saveSetting(state.currentSetting);
  }

  void _updateFontFamily(String newFontFamily) {
    state = state.copy(
      newSetting: state.currentSetting.copy(fontFamily: newFontFamily)
    );
    ref.read(settingProvider.notifier).state = state.currentSetting;

    settingRepository.saveSetting(state.currentSetting);
  }

  void _initiate() async {
    final savedSetting = await settingRepository.getCurrentSetting();
    state = state.copy(newSetting: savedSetting);
  }
}