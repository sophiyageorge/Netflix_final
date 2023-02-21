import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/new_hot/discovery_resp/discovery_resp.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/new_hot/hot_and_new_service.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../domain/core/api_end_points.dart';

@LazySingleton(as: HotAndNewService)
class HotAndNewImplementation implements HotAndNewService {
  @override
  Future<Either<MainFailure, DiscoveryResp>> getHotAndNewMovieData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final downloadsList = (response.data['results'] as List).map((e) {

        final result = DiscoveryResp.fromJson(response.data);
        print(result);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, DiscoveryResp>> getHotAndNewTvData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);
      print(ApiEndPoints.hotAndNewTv);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final downloadsList = (response.data['results'] as List).map((e) {

        final result = DiscoveryResp.fromJson(response.data);
        print(result);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
