import 'package:abc123/core/constants/audio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

import 'dart:io';

class LandscapeVideoScreen extends StatefulWidget {
  final String videoUrl;
  const LandscapeVideoScreen({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<LandscapeVideoScreen> createState() => _LandscapeVideoScreenState();
}

class _LandscapeVideoScreenState extends State<LandscapeVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Yalnızca yatay moda zorla ve sistem çubuklarını gizle
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    // Sistem ayarlarını eski haline getir
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                SizedBox.expand(
                  child: VideoPlayer(_controller),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Slider(
                    value: _controller.value.position.inSeconds.toDouble(),
                    min: 0.0,
                    max: _controller.value.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _controller.seekTo(Duration(seconds: value.toInt()));
                      });
                    },
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class LocalVideoScreen extends StatefulWidget {
  const LocalVideoScreen({Key? key}) : super(key: key);

  @override
  State<LocalVideoScreen> createState() => _LocalVideoScreenState();
}

class _LocalVideoScreenState extends State<LocalVideoScreen> {
  VideoPlayerController? _controller;

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      _controller?.dispose();
      _controller = VideoPlayerController.file(File(result.files.single.path!))
        ..initialize().then((_) {
          setState(() {});
          _controller?.play();
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Yerel Video Oynatıcı')),
      body: Center(
        child: _controller == null
            ? ElevatedButton(
                onPressed: _pickVideo,
                child: Text('Video Seç ve Oynat'),
              )
            : _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  )
                : CircularProgressIndicator(),
      ),
      floatingActionButton: _controller != null
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}

class AssetVideoScreen extends StatefulWidget {
  const AssetVideoScreen({Key? key}) : super(key: key);

  @override
  State<AssetVideoScreen> createState() => _AssetVideoScreenState();
}

class _AssetVideoScreenState extends State<AssetVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _controller = VideoPlayerController.asset(AppAudios.tutorialVideo)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
          if (_controller.value.isInitialized)
            Positioned(
              left: 0,
              right: 0,
              bottom: 80,
              child: Slider(
                value: _controller.value.position.inSeconds.toDouble(),
                min: 0.0,
                max: _controller.value.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _controller.seekTo(Duration(seconds: value.toInt()));
                  });
                },
              ),
            ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
          // Geri butonu ekle
          Positioned(
            top: 24,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
