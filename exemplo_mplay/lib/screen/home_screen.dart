import 'package:exemplo_mplay/service/music_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MusicService _musicService = MusicService();

  Future<void> _musicList() async{
    try {
      await _musicService.fetchListMusic();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:  const Text('Music Player'),
      ),
      body: 
      Padding(padding: EdgeInsets.all(8),
      child: Center(
        child:FutureBuilder(
          future: _musicList(),
         builder: (context,snapshot){
          if(_musicService.listMusic.isNotEmpty){
            return ListView.builder(
              itemCount: _musicService.listMusic.length,
               itemBuilder: (context,index) {
                  return ListTile(
                    title: Text(_musicService.listMusic[index].title),
                    subtitle: Text(_musicService.listMusic[index].artist),
                  );
                });
            }else{
               return CircularProgressIndicator();
            }
          })))
    );
  }
}