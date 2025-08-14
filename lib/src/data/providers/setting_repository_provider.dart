import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/providers/auth_provider.dart';
import 'package:hr_self_service/src/data/settings/storage_setting_repository.dart';
import 'package:hr_self_service/src/domain/repository/setting_repository.dart';

final settingRepositoryProvider = Provider<SettingRepository>(
  (ref) => StorageSettingRepository(
    ref.read(storageServiceProvider)
  )
);