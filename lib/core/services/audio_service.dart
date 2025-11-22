import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint('AudioService init: volume=$_currentVolume');
    } catch (e) {
      debugPrint('AudioService init hatası: $e');
    }
  }

  Future<void> playBackground(String assetPath, {bool loop = true}) async {
    try {
      await _bgPlayer.stop();
      await _bgPlayer
          .setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
      await _bgPlayer.setVolume(_currentVolume);
      await _bgPlayer.play(AssetSource(assetPath));
      debugPrint('Arka plan müziği başlatıldı: $assetPath');
    } catch (e) {
      debugPrint('Arka plan müziği başlatılamadı: $e');
    }
  }

  Future<void> stopBackground() async {
    await _bgPlayer.stop();
  }

  Future<void> playEffect(String assetPath) async {
    await _effectPlayer.setReleaseMode(ReleaseMode.stop);
    await _effectPlayer.play(AssetSource(assetPath));
  }

  Future<void> playEffectAndResumeBackground(
      String effectPath, String bgPath) async {
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
    } catch (e) {
      debugPrint('Ses seviyesi kaydedilemedi: $e');
    }
  }
}
