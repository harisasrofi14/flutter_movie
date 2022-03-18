import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_show_model.dart';

class TvShowResponse extends Equatable {
  final List<TvShowModel> tvShowList;

  const TvShowResponse({required this.tvShowList});

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
        tvShowList: List<TvShowModel>.from((json["results"] as List)
            .map((x) => TvShowModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  @override
  List<Object> get props => [tvShowList];
}
