import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:netflix_app/domain/new_hot/discovery_resp/discovery_resp.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, DiscoveryResp>> getHotAndNewMovieData();
  Future<Either<MainFailure, DiscoveryResp>> getHotAndNewTvData();
}
