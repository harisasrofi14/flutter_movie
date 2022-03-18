import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/genre.dart';

class TvShowGenreModel extends Equatable {
  const TvShowGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory TvShowGenreModel.fromJson(Map<String, dynamic> json) =>
      TvShowGenreModel(
        id: json["id"],
        name: json["name"],
      );


  TvShowGenre toEntity() {
    return TvShowGenre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
