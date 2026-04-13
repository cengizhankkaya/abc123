import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal() {
    // Android/iOS ses bağlamını ayarla (audioplayers ^7.x uyumlu)
    final context = AudioContext(
      android: AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: false,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.gain,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: {AVAudioSessionOptions.duckOthers},
      ),
    );
    _bgPlayer.setAudioContext(context);
    _effectPlayer.setAudioContext(context);
  }

  final AudioPlayer _bgPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  AppLogger get _log => getIt<AppLogger>();

  static const String _volumeKey = 'global_volume';
  double _currentVolume = 1.0;

  double get currentVolume => _currentVolume;

  /// Uygulama başlarken daha önce kaydedilmiş ses seviyesini yükler
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentVolume = prefs.getDouble(_volumeKey) ?? 1.0;
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

  Future<void> stopBackground() async {
    await _bgPlayer.stop();
  }

  Future<void> playEffect(String assetPath) async {
    await _effectPlayer.setReleaseMode(ReleaseMode.stop);
    await _effectPlayer.play(AssetSource(assetPath));
  }

  Future<void> playEffectAndResumeBackground(String effectPath, String bgPath) async {
    await _bgPlayer.pause();
    await _effectPlayer.setReleaseMode(ReleaseMode.stop);
    await _effectPlayer.play(AssetSource(effectPath));
    await _effectPlayer.onPlayerComplete.first;
    await _bgPlayer.resume();
  }

  Future<void> dispose() async {
    await _bgPlayer.dispose();
    await _effectPlayer.dispose();
  }

  Future<void> setVolume(double volume) async {
    _currentVolume = volume.clamp(0.0, 1.0);
    await _bgPlayer.setVolume(_currentVolume);
    await _effectPlayer.setVolume(_currentVolume);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_volumeKey, _currentVolume);
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
