import 'package:abc123/core/domain/ports/i_remote_config_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Firebase Remote Config'i kullanan [IRemoteConfigService] implementasyonu.
///
/// Remote Config'deki parametreler:
///
/// | Parametre              | Tip    | Default | Açıklama                              |
/// |------------------------|--------|---------|---------------------------------------|
/// | minimum_build_number   | Number | 1       | Zorla güncelleme eşiği                |
/// | optional_build_number  | Number | 0       | Opsiyonel güncelleme önerisi eşiği   |
/// | whats_new              | String | ""      | Güncelleme ekranında gösterilecek metin|
@LazySingleton(as: IRemoteConfigService)
final class RemoteConfigService implements IRemoteConfigService {
  RemoteConfigService() : _remoteConfig = FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  static const _kMinimumBuildNumber = 'minimum_build_number';
  static const _kOptionalBuildNumber = 'optional_build_number';
  static const _kWhatsNew = 'whats_new';

  @override
  Future<void> fetchAndActivate() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 15),
          minimumFetchInterval: kDebugMode ? Duration.zero : const Duration(hours: 1),
        ),
      );

      await _remoteConfig.setDefaults(const {
        _kMinimumBuildNumber: 1,
        _kOptionalBuildNumber: 0,
        _kWhatsNew: '',
      });

      await _remoteConfig.fetchAndActivate();
    } on Exception catch (_) {
      // Ağ hatası vb. durumda varsayılan değerler kullanılmaya devam eder.
    }
  }

  @override
  int get minimumBuildNumber => _remoteConfig.getInt(_kMinimumBuildNumber);

  @override
  int get optionalBuildNumber => _remoteConfig.getInt(_kOptionalBuildNumber);

  @override
  String get whatsNew => _remoteConfig.getString(_kWhatsNew);
}
