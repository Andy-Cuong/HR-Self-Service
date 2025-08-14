import 'package:flutter/material.dart';
import 'package:hr_self_service/src/data/services/storage_service.dart';
import 'package:hr_self_service/src/domain/repository/setting_repository.dart';
import 'package:hr_self_service/src/ui/settings/setting_model.dart';

class StorageSettingRepository implements SettingRepository {
  final StorageService storageService;

  StorageSettingRepository(this.storageService);

  @override
  Future<SettingModel?> getCurrentSetting() async {
    final alpha = double.tryParse(await storageService.getData('alpha_channel') ?? '');
    final red = double.tryParse(await storageService.getData('red_channel') ?? '');
    final green = double.tryParse(await storageService.getData('green_channel') ?? '');
    final blue = double.tryParse(await storageService.getData('blue_channel') ?? '');
    final fontFamily = await storageService.getData('font_family');

    if (alpha == null || red == null || green == null || blue == null || fontFamily == null) {
      return null;
    }

    return SettingModel(
      seedColor: Color.from(
        alpha: alpha,
        red: red,
        green: green,
        blue: blue
      ),
      fontFamily: fontFamily
    );
  }

  @override
  Future<void> saveSetting(SettingModel newSetting) async {
    await storageService.writeData('alpha_channel', newSetting.seedColor.a.toString());
    await storageService.writeData('red_channel', newSetting.seedColor.r.toString());
    await storageService.writeData('green_channel', newSetting.seedColor.g.toString());
    await storageService.writeData('blue_channel', newSetting.seedColor.b.toString());
    await storageService.writeData('font_family', newSetting.fontFamily);
  }
}