import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/home/home_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/presentation/home/custom_button_widget.dart';
import 'package:netflix_app/presentation/home/number_card.dart';

import '../../core/constants.dart';
import '../../core/string.dart';
import '../widgets/main_card.dart';
import '../widgets/main_title.dart';
import '../widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
// final  List<String> posterList ;
  final _imageurl =
      "https://www.freepnglogos.com/uploads/netflix-logo-circle-png-5.png";
  // "https://www.citypng.com/public/uploads/preview/-11594682698soxrlignre.png";
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: ((context, value, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                print(direction);
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = true;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = false;
                }
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                    if (state.isloading) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    } else if (state.hasError) {
                      return const Center(
                          child: Text(
                        'Error while getting data',
                        style: TextStyle(color: Colors.white),
                      ));
                    }

                    // release past year
                    final _releasePastYear = state.pastYearMovieList.map((m) {
                      return '$imageUrl${m.posterPath}';
                    }).toList();
                    _releasePastYear.shuffle();

                    // trending
                    final _trending = state.trendingMovieList.map((m) {
                      return '$imageUrl${m.posterPath}';
                    }).toList();
                    _trending.shuffle();
                    // tense dramas
                    final _tenseDramas = state.tenseDramasMovieList.map((m) {
                      return '$imageUrl${m.posterPath}';
                    }).toList();
                    _tenseDramas.shuffle();
                    // southindian movie

                    final _southindian = state.southIndianMovieList.map((m) {
                      return '$imageUrl${m.posterPath}';
                    }).toList();
                    _southindian.shuffle();

                    final _top10tvShows = state.trendingtvList.map((m) {
                      return '$imageUrl${m.posterPath}';
                    }).toList();
                    _top10tvShows.shuffle();
                    //

                    return ListView(children: [
                      CustomButtonWidget(),
                      MainTitleCard(
                          posterList: _releasePastYear.sublist(0, 10),
                          title: "Released in the past year"),
                      kheight,
                      MainTitleCard(
                        title: "Trending Now",
                        posterList: _trending.sublist(0, 10),
                      ),
                      kheight,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainTitle(title: "Top 10 TV Shows in India today"),
                          kheight,
                          LimitedBox(
                            maxHeight: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                10,
                                (index) => NumberCard(
                                  index: index,
                                  imageUrl: _top10tvShows[index],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      kheight,
                      MainTitleCard(
                        title: "Tense Dramas",
                        posterList: _tenseDramas,
                      ),
                      kheight,
                      MainTitleCard(
                        title: "South Indian Cinema",
                        posterList: _southindian.sublist(0, 10),
                      ),
                      kheight,
                      //                   ],
                      //                 ),
                    ]
                        //           ),
                        //         );
                        //       }
                        //               //}),
                        //            // ],
                        //           ),

                        //           // ),
                        //       //  );
                        );
                  }),
                  scrollNotifier.value == false
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(milliseconds: 1000),
                            width: double.infinity,
                            height: 90,
                            color: Colors.black.withOpacity(0.3),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      _imageurl,
                                      width: 60,
                                      height: 60,
                                    ),
                                    Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    kwidth,
                                    Container(
                                      width: 30,
                                      height: 30,
                                      color: Colors.blue,
                                    ),
                                    kwidth
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("TV Shows", style: ktextStyle),
                                    Text("Movies", style: ktextStyle),
                                    Text("Categories", style: ktextStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : kheight,
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
