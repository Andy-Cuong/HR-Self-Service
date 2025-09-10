import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/setting_repository_provider.dart';
import 'package:hr_self_service/src/ui/settings/setting_model.dart';
import 'package:hr_self_service/src/ui/settings/setting_state.dart';
import 'package:hr_self_service/src/ui/settings/setting_viewmodel.dart';

final settingViewModelProvider = NotifierProvider<SettingViewModel, SettingState>(
  SettingViewModel.new
);

final savedSettingProvider = FutureProvider<SettingModel>((ref) async {
  final settingRepository = ref.read(settingRepositoryProvider);
  final savedSetting = await settingRepository.getCurrentSetting();
  return savedSetting ?? SettingModel(seedColor: Colors.deepPurple, fontFamily: 'Roboto');
});