// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SongModel {
  final String artist;
  final String song_url;
  final String thumbnail_url;
  final String song_name;
  final String id;
  final String hex_code;

  SongModel({
    required this.artist,
    required this.song_url,
    required this.thumbnail_url,
    required this.song_name,
    required this.id,
    required this.hex_code,
  });

  SongModel copyWith({
    String? artist,
    String? song_url,
    String? thumbnail_url,
    String? song_name,
    String? id,
    String? hex_code,
  }) {
    return SongModel(
      artist: artist ?? this.artist,
      song_url: song_url ?? this.song_url,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_name: song_name ?? this.song_name,
      id: id ?? this.id,
      hex_code: hex_code ?? this.hex_code,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artist': artist,
      'song_url': song_url,
      'thumbnail_url': thumbnail_url,
      'song_name': song_name,
      'id': id,
      'hex_code': hex_code,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      artist: map['artist'] ?? '',
      song_url: map['song_url'] ?? '',
      thumbnail_url: map['thumbnail_url'] ?? '',
      song_name: map['song_name'] ?? '',
      id: map['id'] ?? '',
      hex_code: map['hex_code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(artist: $artist, song_url: $song_url, thumbnail_url: $thumbnail_url, song_name: $song_name, id: $id, hex_code: $hex_code)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;

    return other.artist == artist &&
        other.song_url == song_url &&
        other.thumbnail_url == thumbnail_url &&
        other.song_name == song_name &&
        other.id == id &&
        other.hex_code == hex_code;
  }

  @override
  int get hashCode {
    return artist.hashCode ^
        song_url.hashCode ^
        thumbnail_url.hashCode ^
        song_name.hashCode ^
        id.hashCode ^
        hex_code.hashCode;
  }
}
