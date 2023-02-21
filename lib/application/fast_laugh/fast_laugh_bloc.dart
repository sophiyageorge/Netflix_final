import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyvideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
];

ValueNotifier<Set<int>> likedVideosNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo _downloadsService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      // sending loading to ui

      emit(
        const FastLaughState(
          videoList: [],
          isLoading: true,
          isError: false,
        ),
      );
      // get trending movies

      final _result = await _downloadsService.getDownloadsImage();
      final _state = _result.fold((l) {
        return FastLaughState(
          videoList: [],
          isLoading: false,
          isError: true,
        );
      }, (r) {
        return FastLaughState(
          videoList: r,
          isLoading: false,
          isError: false,
        );
      });

      // send to ui

      emit(_state);
      //
    });
    on<LikeVideo>((event, emit) async {
      likedVideosNotifier.value.add(event.id);
    });

    on<UnlikeVideo>((event, emit) {
      likedVideosNotifier.value.remove(event.id);
    });
  }
}
