part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tenseDramasMovieList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> trendingtvList,
    required bool isloading,
    required bool hasError,
  }) = _Initial;

  factory HomeState.initial() => HomeState(
      stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tenseDramasMovieList: [],
      southIndianMovieList: [],
      trendingtvList: [],
      isloading: false,
      hasError: false);
}
