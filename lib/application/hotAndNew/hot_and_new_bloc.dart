import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/new_hot/hot_and_new_service.dart';

import '../../domain/new_hot/discovery_resp/discovery_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    /* get hot and new movie data */

    on<LoadDataInComingSoon>((event, emit) async {
// send loading to ui

      emit(const HotAndNewState(
          comingSoonList: [],
          EveryOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
// get data from remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();

//data to state
      final _newstate = _result.fold((MainFailure failure) {
        return const HotAndNewState(
            EveryOneIsWatchingList: [],
            comingSoonList: [],
            isLoading: false,
            hasError: true);
      }, (DiscoveryResp resp) {
        return HotAndNewState(
            comingSoonList: resp.results,
            EveryOneIsWatchingList: state.EveryOneIsWatchingList,
            isLoading: false,
            hasError: false);
      });
      emit(_newstate);
    });

    /* get hot and new tv data */
    on<LoadDataEveryoneIsWatching>((event, emit) async {
      // send loading to ui

      emit(const HotAndNewState(
          comingSoonList: [],
          EveryOneIsWatchingList: [],
          isLoading: true,
          hasError: false));
// get data from remote
      final _result = await _hotAndNewService.getHotAndNewTvData();
      print(_result);
//data to state
      final _newstate = _result.fold((MainFailure failure) {
        return const HotAndNewState(
            EveryOneIsWatchingList: [],
            comingSoonList: [],
            isLoading: false,
            hasError: true);
      }, (DiscoveryResp resp) {
        print(resp.results);
        // final respList = resp.results != null ? resp.results! : [];
        return HotAndNewState(
            comingSoonList: state.comingSoonList,
            EveryOneIsWatchingList: resp.results,
            isLoading: false,
            hasError: false);
      });
      emit(_newstate);
    });
  }
}
