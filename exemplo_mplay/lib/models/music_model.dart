class MusicModel{
  final String title;
  final String artist;
  final String url;

  //costrutor
  MusicModel({required this.title, required this.artist, required this.url});

  //fromJson
  factory MusicModel.fromJson(Map<String, dynamic> json){
    return MusicModel(
      title: json['title'],
      artist: json['artist'],
      url: json['url'],
    );
  }
  
}