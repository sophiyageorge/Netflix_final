import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/new_hot/hot_and_new_service.dart';

import '../../domain/new_hot/discovery_resp/discovery_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //send loading to ui

    emit(state.copyWith(isloading: true, hasError: false));

    on<GetHomeScreenData>((event, emit) async {
      final _movieResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();

      final _state1 = _movieResult.fold((MainFailure failure) {
        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingtvList: [],
            isloading: false,
            hasError: true);
      }, (DiscoveryResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southindian = resp.results;
        pastYear.shuffle;
        trending.shuffle;
        dramas.shuffle;
        southindian.shuffle;
        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tenseDramasMovieList: dramas,
            southIndianMovieList: southindian,
            trendingtvList: state.trendingtvList,
            isloading: false,
            hasError: false);
      });

      emit(_state1);
      final _state2 = _tvResult.fold((MainFailure failure) {
        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingtvList: [],
            isloading: false,
            hasError: true);
      }, (DiscoveryResp resp) {
        final top10List = resp.results;

        return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: top10List,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingtvList: top10List,
            isloading: false,
            hasError: false);
      });
      emit(_state2);
    });
  }
}
