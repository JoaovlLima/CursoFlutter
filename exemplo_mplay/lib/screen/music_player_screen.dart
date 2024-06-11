import 'package:audioplayers/audioplayers.dart';
import 'package:exemplo_mplay/models/music_model.dart';
import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  final MusicModel music;
  const MusicPlayerScreen({super.key, required this.music});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playMusic() async {
    try {
      await _audioPlayer.play(UrlSource(widget.music.url));
    } catch (e) {
      print("Erro ao tocar a música: $e");
    }
  }

  void _pauseMusic() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print("Erro ao pausar a música: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.music.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _playMusic,
              child: Text('Tocar'),
            ),
            ElevatedButton(
              onPressed: _pauseMusic,
              child: Text('Pausar'),
            ),
          ],
        ),
      ),
    );
  }
}
