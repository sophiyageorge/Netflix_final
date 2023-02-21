import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/string.dart';
import 'package:netflix_app/presentation/widgets/video_widget.dart';

import '../../application/hotAndNew/hot_and_new_bloc.dart';
import '../../core/constants.dart';
import '../home/custom_button_widget.dart';
import '../widgets/app_bar_widget.dart';
import 'widgets/coming_soon_widget.dart';
import 'widgets/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
            actions: [
              const Icon(
                Icons.cast,
                size: 30,
                color: Colors.white,
              ),
              kwidth,
              Container(
                color: Colors.blue,
                width: 30,
                height: 30,
              ),
              kwidth,
            ],
            bottom: TabBar(
                unselectedLabelColor: kwhite,
                labelColor: kBlackColor,
                isScrollable: true,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color: kwhite,
                  borderRadius: kRadius20,
                ),
                tabs: [
                  Tab(
                    text: "🍟 Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyone's watching",
                  )
                ]),
          ),
        ),
        body: TabBarView(
          children: [
            ComingSoonList(
              key: Key('coming_soon'),
            ),
            EveryOneIsWatchingList(
              key: Key('Everyone_is_watching'),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildComingSoon() {
  //   return }

}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context).add(LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state.hasError) {
            return Center(
              child: Text('Error while loading comig soon list'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return Center(
              child: Text('Coming Soon List Empty'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                final movie = state.comingSoonList[index];
                if (movie.id == null) {
                  return SizedBox();
                }
                final _date = DateTime.parse(movie.releaseDate!);
                final _formatedDate = DateFormat.yMMMMd('en_US').format(_date);

                return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: _formatedDate
                        .split(' ')
                        .first
                        .substring(0, 3)
                        .toUpperCase(),
                    day: movie.releaseDate!.split('-')[1],
                    posterPath: '$imageUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No Title',
                    description: movie.overview ?? 'No description');
              },
            );
          }
        },
      ),
    );
  }
}

class EveryOneIsWatchingList extends StatelessWidget {
  const EveryOneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(LoadDataEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(LoadDataEveryoneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          } else if (state.hasError) {
            return Center(
              child: Text('Error while loading comig soon list'),
            );
          } else if (state.EveryOneIsWatchingList.isEmpty) {
            return Center(
              child: Text('Everyone is watching List Empty'),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                final tv = state.EveryOneIsWatchingList[index];
                if (tv.id == null) {
                  return SizedBox();
                }

                return EveryonesWatching(
                    posterPath: '$imageUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No Name Provided',
                    description: tv.overview ?? 'No Overview');
              },
            );
          }
        },
      ),
    );
  }
}
