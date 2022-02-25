import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_show_popular/tv_show_popular_bloc.dart';
import 'package:tv/presentation/widgets/tv_show_card_list.dart';

class PopularTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-show';

  const PopularTvShowPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowPageState createState() => _PopularTvShowPageState();
}

class _PopularTvShowPageState extends State<PopularTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<TvShowPopularBloc>(context).add(OnGetPopularTvShow()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
          builder: (context, state) {
            if (state is TvShowPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowPopularHasData) {
              final data = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.length,
              );
            } else {
              return const Center(child: Text('Failed'));
            }
          },
        ),
      ),
    );
  }
}
