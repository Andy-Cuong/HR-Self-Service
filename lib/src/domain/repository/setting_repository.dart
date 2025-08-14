import 'package:hr_self_service/src/ui/settings/setting_model.dart';

abstract class SettingRepository {
  Future<SettingModel?> getCurrentSetting();
  Future<void> saveSetting(SettingModel newSetting);
}