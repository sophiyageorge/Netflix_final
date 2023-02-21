import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/presentation/fast_and_laugh/widgets/video_list_item.dart';

import '../../application/fast_laugh/fast_laugh_bloc.dart';

class ScreenFastAndLaugh extends StatelessWidget {
  ScreenFastAndLaugh({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughBloc, FastLaughState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: const CircularProgressIndicator(strokeWidth: 2),
              );
            } else if (state.isError) {
              return const Center(
                child: Text('Error while geting data'),
              );
            } else if (state.videoList.isEmpty) {
              return const Center(
                child: Text('VideoList is empty'),
              );
            } else {
              return PageView(
                  scrollDirection: Axis.vertical,
                  children: List.generate(state.videoList.length, (index) {
                    return VideoListItemInheritedWidget(
                      key: Key(index.toString()),
                      widget: VideoListItem(
                        index: index,
                      ),
                      movieData: state.videoList[index],
                    );
                  }));
            }
          },
        ),
      ),
    );
  }
}
