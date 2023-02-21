import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failure/main_failure.dart';

import 'model/search/search.dart';

abstract class SearchService {
  Future<Either<MainFailure, Search>> searchMovies({
    required String movieQuery,
  });
}
