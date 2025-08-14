import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/setting_repository_provider.dart';
import 'package:hr_self_service/src/ui/settings/setting_model.dart';
import 'package:hr_self_service/src/ui/settings/setting_state.dart';
import 'package:hr_self_service/src/ui/settings/setting_viewmodel.dart';

final settingViewModelProvider = StateNotifierProvider<SettingViewModel, SettingState>(
  (ref) => SettingViewModel(
    ref,
    ref.read(settingRepositoryProvider)
  )
);

final savedSettingProvider = FutureProvider<SettingModel>((ref) async {
  final settingRepository = ref.read(settingRepositoryProvider);
  final savedSetting = await settingRepository.getCurrentSetting();
  return savedSetting ?? SettingModel(seedColor: Colors.deepPurple, fontFamily: 'Roboto');
});

// Global setting provider for the whole app
final settingProvider = StateProvider<SettingModel>(
  (ref) => SettingModel(seedColor: Colors.deepPurple, fontFamily: 'Roboto')
);