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
  var cont = 0;
  var icons = Icons.play_arrow;

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
           IconButton(
              onPressed: () {
                cont++;
                if(cont == 1){
                  _playMusic();
                  print(cont);
                  icons = Icons.pause;
                  Icon(icons);
                }
                else{
                  _pauseMusic();
                   print(cont);
                  icons = Icons.play_arrow;
                  cont = 0;
                  Icon(icons);
                  
                }
              },
              icon: Icon(icons),
            ),
            
          ],
        ),
      ),
    );
  }
}
