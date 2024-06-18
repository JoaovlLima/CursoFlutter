import 'package:exemplo_mplay/models/music_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerScreen extends StatefulWidget {
  final MusicModel music;

  const MusicPlayerScreen({Key? key, required this.music}) : super(key: key);

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  IconData playPauseIcon = Icons.play_arrow;

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

  void _togglePlayPause() async {
    if (isPlaying) {
      await _pauseMusic();
    } else {
      await _playMusic();
    }
    setState(() {
      isPlaying = !isPlaying;
      playPauseIcon = isPlaying ? Icons.pause : Icons.play_arrow;
    });
  }

  Future<void> _playMusic() async {
    try {
      await _audioPlayer.play(UrlSource(widget.music.url));
    } catch (e) {
      print("Erro ao tocar a música: $e");
    }
  }

  Future<void> _pauseMusic() async {
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
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.music_note,
                      size: 80,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.music.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.music.artist,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(
                      playPauseIcon,
                      size: 64,
                      color: Colors.deepPurple,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
