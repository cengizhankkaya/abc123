import 'package:audioplayers/audioplayers.dart';

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

  Future<void> playBackground(String assetPath, {bool loop = true}) async {
    try {
      await _bgPlayer.stop();
      await _bgPlayer
          .setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
      await _bgPlayer.setVolume(1.0);
      await _bgPlayer.play(AssetSource(assetPath));
      print('Arka plan müziği başlatıldı: $assetPath');
    } catch (e) {
      print('Arka plan müziği başlatılamadı: $e');
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
    await _bgPlayer.setVolume(volume);
    await _effectPlayer.setVolume(volume);
  }
}
