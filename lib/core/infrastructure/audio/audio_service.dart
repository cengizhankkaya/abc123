import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: IAudioService)
class AudioService implements IAudioService {
  AudioService(this._log, this._prefs) {
    // Android/iOS ses bağlamını ayarla (audioplayers ^7.x uyumlu)
    final context = AudioContext(
      android: const AudioContextAndroid(),
      iOS: AudioContextIOS(
        options: const {AVAudioSessionOptions.duckOthers},
      ),
    );
    _bgPlayer.setAudioContext(context);
    _effectPlayer.setAudioContext(context);
  }

  final AppLogger _log;
  final SharedPreferences _prefs;

  final AudioPlayer _bgPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  static const String _volumeKey = 'global_volume';
  double _currentVolume = 1;

  @override
  double get currentVolume => _currentVolume;

  /// Uygulama başlarken daha önce kaydedilmiş ses seviyesini yükler
  @override
  Future<void> init() async {
    try {
      _currentVolume = _prefs.getDouble(_volumeKey) ?? 1.0;
      await _bgPlayer.setVolume(_currentVolume);
      await _effectPlayer.setVolume(_currentVolume);
      _log.debug(
        'init volume',
        tag: 'AudioService',
        data: {'volume': _currentVolume},
      );
    } catch (e, st) {
      _log.error(
        'init failed',
        tag: 'AudioService',
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> playBackground(String assetPath, {bool loop = true}) async {
    try {
      await _bgPlayer.stop();
      await _bgPlayer.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
      await _bgPlayer.setVolume(_currentVolume);
      await _bgPlayer.play(AssetSource(assetPath));
      _log.debug(
        'Background started',
        tag: 'AudioService',
        data: {'assetPath': assetPath},
      );
    } catch (e, st) {
      _log.error(
        'Background start failed',
        tag: 'AudioService',
        error: e,
        stackTrace: st,
        data: {'assetPath': assetPath},
      );
    }
  }

  @override
  Future<void> stopBackground() async {
    await _bgPlayer.stop();
  }

  @override
  Future<void> playEffect(String assetPath) async {
    try {
      await _effectPlayer.setReleaseMode(ReleaseMode.stop);
      await _effectPlayer.setVolume(_currentVolume);
      await _effectPlayer.play(AssetSource(assetPath));
    } catch (e, st) {
      _log.error(
        'playEffect failed',
        tag: 'AudioService',
        error: e,
        stackTrace: st,
        data: {'assetPath': assetPath},
      );
    }
  }

  @override
  Future<void> playEffectAndResumeBackground(String effectPath, String bgPath) async {
    await _bgPlayer.pause();
    await _effectPlayer.setReleaseMode(ReleaseMode.stop);
    await _effectPlayer.play(AssetSource(effectPath));
    await _effectPlayer.onPlayerComplete.first;
    await _bgPlayer.resume();
  }

  @override
  Future<void> dispose() async {
    await _bgPlayer.dispose();
    await _effectPlayer.dispose();
  }

  @override
  Future<void> setVolume(double volume) async {
    _currentVolume = volume.clamp(0.0, 1.0);
    await _bgPlayer.setVolume(_currentVolume);
    await _effectPlayer.setVolume(_currentVolume);
    try {
      await _prefs.setDouble(_volumeKey, _currentVolume);
    } catch (e, st) {
      _log.error(
        'Volume persist failed',
        tag: 'AudioService',
        error: e,
        stackTrace: st,
      );
    }
  }
}
